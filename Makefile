.PHONY: help install install_dev add add_dev lint_check lint_fix format_check format_fix

install:
	@echo "Installing Training Pipeline..."
	# Set the Python version to use for the poetry environment to Python 3.10
	# Disable the keyring functionality and install project dependencies using poetry
	# Keyring is a Python library that provides a standardized way to access the system's keyring service for securely storing and retrieving credentials,
	# such as passwords and tokens. It supports various backends for different operating systems and environments. H
	#Here’s why keyring is useful:
	#Security: It allows sensitive information like passwords and API keys to be stored securely rather than hardcoding them into scripts or configuration files.
	#Convenience: By using a keyring, applications can retrieve stored credentials programmatically, reducing the need for manual input and making automation easier.
	#Cross-platform Support: Keyring works across different operating systems, such as Windows, macOS, and various Linux distributions, providing a consistent interface for credential storage.
	# Install a specific version of the torch package (2.0.1) within the poetry environment
	poetry env use $(shell which python3.10) && \
	PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring poetry install && \
	poetry run pip install torch==2.0.1

install_dev: install
	"Setting up Dev Environment"
	PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring poetry install --with dev

add:
	"Adding new python package to production"
	PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring poetry add $(package)

add_dev:
	"Adding new python package to dev"
	PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring poetry add --group dev $(package)

lint_check:
	@echo "checking code for lint issues"
	poetry run ruff check .

lint_fix:
	@echo "Fixing Linting Issue..."
	poetry run ruff check --fix .

format_check:
	@echo "Checking for code format issues..."
	poetry run black --check .

format_fix:
	@echo "Fixing code format issues..."
	poetry run black .