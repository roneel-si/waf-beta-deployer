# WAF Beta Deployer

A full-stack web application for executing WAF beta deployment scripts. This application provides a simple and intuitive UI to manage and execute the deployment scripts for various clients.

## Features

-   List all available deployment scripts
-   Execute scripts with real-time updates via polling
-   View script execution status
-   Clear terminal output
-   Deployment locking to prevent multiple simultaneous deployments

## Technologies Used

-   Node.js
-   Express.js
-   EJS (for templating)
-   Bootstrap (for styling)
-   JavaScript polling for real-time updates

## Installation

1. Clone the repository

```
git clone https://github.com/roneel-si/waf-beta-deployer.git
cd waf-beta-deployer
```

2. Install dependencies

```
npm install
```

3. Start the application

```
npm start
```

4. Access the application at `http://localhost:3000`

## Development

For development with live reloading:

```
npm run dev
```

## License

ISC
