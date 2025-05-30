#!/bin/bash

# Script to install PostgreSQL 16 and create a database on Ubuntu

# Update package list
echo "Updating package list..."
sudo apt update

# Install prerequisite packages
echo "Installing prerequisite packages..."
sudo apt install -y wget gnupg2

# Add PostgreSQL official repository
echo "Adding PostgreSQL official repository..."
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

# Import the PostgreSQL repository signing key
echo "Importing PostgreSQL repository signing key..."
wget -qO - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Update package list after adding the new repository
echo "Updating package list again..."
sudo apt update

# Install PostgreSQL 16
echo "Installing PostgreSQL version 16..."
sudo apt install -y postgresql-16

# Start and enable PostgreSQL service
echo "Starting PostgreSQL service..."
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Create a database 'mga' as the 'postgres' user
echo "Creating database 'mga'..."
sudo -u postgres createdb mga

# Output PostgreSQL version to confirm installation
echo "PostgreSQL installation completed. Version info:"
sudo -u postgres psql --version
