document.addEventListener("DOMContentLoaded", () => {
	// DOM elements
	const scriptItems = document.querySelectorAll(".script-item");
	const executeBtn = document.getElementById("execute-btn");
	const clearBtn = document.getElementById("clear-btn");
	const currentScriptDisplay = document.getElementById("current-script");
	const outputContainer = document.getElementById("output");
	const statusDisplay = document.getElementById("status");
	const terminal = document.getElementById("terminal");

	// Get base path from window object
	const basePath = window.basePath || "";

	// State variables
	let selectedScript = null;
	let isExecuting = false;
	let pollingInterval = null;
	let lastLogCount = 0;

	// Initialize app state
	checkDeploymentStatus();

	// Initial welcome message
	if (outputContainer.innerHTML.trim() === "") {
		outputContainer.innerHTML =
			"Welcome to WAF Beta Deployer. Select a client from the list to deploy.";
	}

	// Poll for deployment status and logs
	function startPolling() {
		// Poll every 1 second
		pollingInterval = setInterval(() => {
			checkDeploymentStatus();
			fetchDeploymentLogs();
		}, 1000);
	}

	function stopPolling() {
		if (pollingInterval) {
			clearInterval(pollingInterval);
			pollingInterval = null;
		}
	}

	// Check deployment status
	function checkDeploymentStatus() {
		fetch(`${basePath}/api/deployment-status?cache-buster=${Date.now()}`)
			.then((response) => response.json())
			.then((data) => {
				isExecuting = data.isDeploying;

				// Update UI based on deployment status
				if (isExecuting) {
					executeBtn.disabled = true;
					executeBtn.classList.add("executing");
					statusDisplay.textContent = `Executing ${data.currentDeployment}...`;

					// If we just detected a deployment, start fetching logs
					if (!pollingInterval) {
						startPolling();
					}
				} else {
					// If deployment completed
					if (data.deploymentStatus) {
						executeBtn.disabled = false;
						executeBtn.classList.remove("executing");
						statusDisplay.textContent =
							data.deploymentStatus === "success"
								? "Deployment completed"
								: "Deployment failed";

						// Check for logs one more time to get final state
						fetchDeploymentLogs();

						// Stop polling if deployment is complete
						if (pollingInterval) {
							setTimeout(stopPolling, 2000);
						}
					} else {
						// No active deployment
						executeBtn.disabled = selectedScript ? false : true;
						executeBtn.classList.remove("executing");
						statusDisplay.textContent = "Ready";
					}
				}
			})
			.catch((error) => {
				console.error("Error checking deployment status:", error);
			});
	}

	// Fetch deployment logs
	function fetchDeploymentLogs() {
		fetch(`${basePath}/api/deployment-logs?cache-buster=${Date.now()}`)
			.then((response) => response.json())
			.then((data) => {
				if (data.logs && data.logs.length > lastLogCount) {
					updateOutputWithLogs(data.logs.slice(lastLogCount));
					lastLogCount = data.logs.length;
				}
			})
			.catch((error) => {
				console.error("Error fetching deployment logs:", error);
			});
	}

	// Update terminal with logs
	function updateOutputWithLogs(newLogs) {
		newLogs.forEach((log) => {
			const outputLine = document.createElement("div");

			if (typeof log === "string") {
				// Handle simple string logs
				outputLine.textContent = log;
				if (log.includes("✅")) {
					outputLine.className = "success-message";
				} else if (log.includes("❌")) {
					outputLine.className = "error-message";
				} else {
					outputLine.className = "stdout";
				}
			} else {
				// Handle object logs with type
				outputLine.className =
					log.type === "stderr" ? "stderr" : "stdout";
				outputLine.textContent = log.data;
			}

			outputContainer.appendChild(outputLine);
			terminal.scrollTop = terminal.scrollHeight;
		});
	}

	// Event listeners for script items
	scriptItems.forEach((item) => {
		item.addEventListener("click", () => {
			// Deselect all script items
			scriptItems.forEach((script) => script.classList.remove("active"));

			// Select the clicked item
			item.classList.add("active");
			selectedScript = item.dataset.script;

			// Update UI
			currentScriptDisplay.textContent = `Deploy: ${selectedScript}`;
			executeBtn.disabled = isExecuting;

			// Clear previous output and show the current selection
			outputContainer.innerHTML = "";
			const selectedLine = document.createElement("div");
			selectedLine.className = "stdout";
			selectedLine.textContent = `Selected: ${selectedScript}`;
			outputContainer.appendChild(selectedLine);
			terminal.scrollTop = 0;

			statusDisplay.textContent = "Ready to deploy";
		});
	});

	// Execute button click handler
	executeBtn.addEventListener("click", () => {
		if (!selectedScript || isExecuting) return;

		// Reset logs counter
		lastLogCount = 0;

		// Send execution request to server
		fetch(`${basePath}/execute?cache-buster=${Date.now()}`, {
			method: "POST",
			headers: {
				"Content-Type": "application/json",
			},
			body: JSON.stringify({
				script: selectedScript,
			}),
		})
			.then((response) => {
				if (!response.ok) {
					return response.json().then((data) => {
						throw new Error(
							data.message || "Unknown error occurred",
						);
					});
				}
				return response.json();
			})
			.then((data) => {
				if (data.success) {
					// Start polling for status and logs
					startPolling();
				}
			})
			.catch((error) => {
				const errorMessage = document.createElement("div");
				errorMessage.className = "error-message";
				errorMessage.textContent = `Error: ${error.message}`;
				outputContainer.appendChild(errorMessage);
				terminal.scrollTop = terminal.scrollHeight;

				statusDisplay.textContent = "Error";
			});
	});

	// Clear output button handler
	clearBtn.addEventListener("click", () => {
		outputContainer.innerHTML = "";
		if (selectedScript) {
			const selectedLine = document.createElement("div");
			selectedLine.className = "stdout";
			selectedLine.textContent = `Selected: ${selectedScript}`;
			outputContainer.appendChild(selectedLine);
		} else {
			const welcomeMessage = document.createElement("div");
			welcomeMessage.className = "stdout";
			welcomeMessage.textContent =
				"Welcome to WAF Beta Deployer. Select a client from the list to deploy.";
			outputContainer.appendChild(welcomeMessage);
		}

		terminal.scrollTop = 0;
		lastLogCount = 0;
	});
});
