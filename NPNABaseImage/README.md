# Server and Docker Setup for Angular Application

This repository contains scripts for:
1. Setting up a production server with Nginx (including PageSpeed module), Node.js, and PHP
2. Building a Docker image for an Angular 7 application

## Contents

1. [Docker Setup](#docker-setup)
2. [Server Setup](#server-setup)
3. [Prerequisites](#prerequisites)
4. [Usage](#usage)
5. [Configuration](#configuration)
6. [Maintenance](#maintenance)

## Docker Setup

File: `Dockerfile.angular7`

Builds a Docker image containing:
- Node.js environment via NVM
- Angular CLI 7.3.10
- Built Angular 7 application

### Features:
- Uses custom base image `ccore_base`
- Installs specific Node.js version (14.15.0)
- Automatically clones and builds the Angular project
- Includes proper cleanup steps

## Server Setup

File: `setup-server.sh`

Automates installation and configuration of:
- System updates and cleanup
- Nginx with PageSpeed module
- Node.js environment (NVM, Node, Angular CLI)
- PHP 7.2 and required dependencies
- Git credential configuration

### Features:
- Automatic installation of all dependencies
- Optimized Nginx configuration with PageSpeed
- Proper permission setup for web directories
- LTS and latest Node.js versions installed

## Prerequisites

### For Docker:
- Docker installed
- Access to `ccore_base` image
- Git repository access

### For Server Setup:
- Ubuntu server (tested on 18.04/20.04)
- Sudo privileges
- Internet access

## Usage

### Docker Image:

1. Build the image:
   ```bash
   docker build -t angular7-app -f Dockerfile.angular7 .
   ```

2. Run the container:
   ```bash
   docker run -it -p 80:80 angular7-app
   ```

### Server Setup:

1. Make the script executable:
   ```bash
   chmod +x setup-server.sh
   ```

2. Run the script (as root or with sudo):
   ```bash
   sudo ./setup-server.sh
   ```

## Configuration

### Docker:
- Update these environment variables in the Dockerfile as needed:
  ```dockerfile
  ENV NODE_VERSION 14.15.0
  ENV ANGULAR_CLI_VERSION 7.3.10
  ENV REPO your-repo-name
  ENV GITURL your.git.url
  ```

### Server:
- The script will prompt for Nginx PageSpeed installation options
- Git credentials will be stored after first use
- Node.js versions can be modified in the script

## Maintenance

### Docker:
- Regularly update the base image
- Review Node.js and Angular versions for security updates

### Server:
- Monitor Nginx and PHP-FPM services:
  ```bash
  systemctl status nginx php7.2-fpm
  ```
- Update PageSpeed module periodically:
  ```bash
  bash <(curl -f -L -sS https://ngxpagespeed.com/install) --nginx-version latest
  ```

## Troubleshooting

### Common Issues:

1. **PageSpeed installation fails**:
   - Ensure all dependencies are installed
   - Check available disk space
   - Verify internet connection

2. **Angular build errors**:
   - Check Node.js version compatibility
   - Verify repository branch exists

3. **Permission issues**:
   - Verify `/var/cache/nginx` ownership
   - Check `/var/www/html` permissions

