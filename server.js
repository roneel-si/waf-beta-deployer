const express = require("express");
const { exec } = require("child_process");
const path = require("path");
const fs = require("fs");

const app = express();

const PORT = process.env.PORT || 3000;
const SCRIPTS_DIR = "/home/ubuntu/web-deployment-scripts";
const BASE_PATH = "/waf-beta-deployer";

// Global deployment state
let isDeploying = false;
let currentDeployment = null;
let deploymentLogs = [];
let deploymentStatus = null;

// Set up view engine
app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));

// Static files
app.use(`${BASE_PATH}/static`, express.static(path.join(__dirname, "public")));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Get all available scripts
const getScripts = () => {
	const scriptFiles = fs
		.readdirSync(SCRIPTS_DIR)
		.filter((file) => file.endsWith(".sh"));
	return scriptFiles.map((script) => ({
		name: script,
		clientName: script.replace("-beta-deploy.sh", "").toUpperCase(),
	}));
};

// Routes
app.get(`${BASE_PATH}`, (req, res) => {
	const scripts = getScripts();
	res.render("index", {
		scripts,
		basePath: BASE_PATH,
	});
});

// API endpoint to get current deployment state
app.get(`${BASE_PATH}/api/deployment-status`, (req, res) => {
	res.json({
		isDeploying,
		currentDeployment,
		deploymentStatus,
	});
});

// API endpoint to get deployment logs
app.get(`${BASE_PATH}/api/deployment-logs`, (req, res) => {
	res.json({ logs: deploymentLogs });
});

// Execute a script
app.post(`${BASE_PATH}/execute`, (req, res) => {
	const { script } = req.body;

	// Validate script name
	if (!script) {
		return res
			.status(400)
			.json({ success: false, message: "Script name is required" });
	}

	// Check if a deployment is already in progress
	if (isDeploying) {
		return res.status(409).json({
			success: false,
			message: `Deployment in progress: ${currentDeployment}. Please wait until it completes.`,
		});
	}

	const scriptPath = path.join(SCRIPTS_DIR, script);

	// Check if script exists
	if (!fs.existsSync(scriptPath)) {
		return res
			.status(404)
			.json({ success: false, message: "Script not found" });
	}

	// Set deployment state
	isDeploying = true;
	currentDeployment = script;
	deploymentLogs = [
		`Executing deployment script: ${script}`,
		`------ Deployment started at ${new Date().toLocaleTimeString()} ------`,
	];
	deploymentStatus = "running";

	// Respond immediately
	res.json({
		success: true,
		message: "Script execution started",
	});

	// Execute the script with sudo
	const child = exec(`sudo chmod +x ${scriptPath} && sudo ${scriptPath}`, {
		maxBuffer: 1024 * 1024 * 10,
	});

	// Capture output
	child.stdout.on("data", (data) => {
		deploymentLogs.push({ type: "stdout", data: data.toString() });
	});

	child.stderr.on("data", (data) => {
		deploymentLogs.push({ type: "stderr", data: data.toString() });
	});

	child.on("close", (code) => {
		deploymentLogs.push(
			code === 0
				? `✅ Deployment completed successfully (exit code: ${code})`
				: `❌ Deployment failed (exit code: ${code})`,
		);

		// Update deployment state
		isDeploying = false;
		deploymentStatus = code === 0 ? "success" : "failed";

		// Keep current deployment name to show what was last deployed
		setTimeout(() => {
			if (!isDeploying) {
				// Reset after 1 hour if no new deployment started
				deploymentStatus = null;
				currentDeployment = null;
			}
		}, 3600000);
	});
});

// Add a root redirect to the base path
app.get("/", (req, res) => {
	res.redirect(BASE_PATH);
});

// Start server
app.listen(PORT, () => {
	console.log(`Server running on http://localhost:${PORT}${BASE_PATH}`);
});
