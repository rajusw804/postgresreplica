#!/bin/bash

# Script to completely remove PostgreSQL from Ubuntu

# Stop PostgreSQL service
echo "Stopping PostgreSQL service..."
sudo systemctl stop postgresql

# Disable PostgreSQL service
echo "Disabling PostgreSQL service..."
sudo systemctl disable postgresql

# Remove PostgreSQL packages
echo "Removing PostgreSQL packages..."
sudo apt-get --purge remove postgresql postgresql-*

# Remove PostgreSQL configuration and data directories
echo "Removing PostgreSQL configuration and data directories..."
sudo rm -rf /etc/postgresql /var/lib/postgresql

# Remove PostgreSQL repository list file
echo "Removing PostgreSQL repository list file..."
sudo rm -f /etc/apt/sources.list.d/pgdg.list

# Remove repository signing key, if necessary
echo "Removing PostgreSQL repository signing key..."
sudo apt-key del ACCC4CF8

# Optionally, clean up any unused packages and dependencies
echo "Cleaning up unused packages and dependencies..."
sudo apt-get autoremove
sudo apt-get autoclean

echo "PostgreSQL removal completed."
