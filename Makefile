
PROJECT = ska-mid-cbf-deployment

PYTHON_RUNNER = poetry run python -m
POETRY_PYTHON_RUNNER = poetry run python -m

# KUBE_NAMESPACE defines the Kubernetes Namespace that will be deployed to
# using Helm.  If this does not already exist it will be created
KUBE_NAMESPACE ?= ska-mid-cbf-deployment

# UMBRELLA_CHART_PATH Path of the umbrella chart to work with
HELM_CHART ?= ska-mid-cbf-deployment
UMBRELLA_CHART_PATH ?= charts

# RELEASE_NAME is the release that all Kubernetes resources will be labelled with
RELEASE_NAME = $(HELM_CHART)

KUBE_APP ?= ska-mid-cbf-deployment

TARANTA ?= false
BOOGIE ?= false
MINIKUBE ?= false

# Expose All Tango Services to the external network (enable Loadbalancer service)
EXPOSE_All_DS ?= true

SKA_TANGO_OPERATOR ?= true

# Chart for testing
K8S_CHART ?= $(HELM_CHART)
K8S_CHARTS ?= $(K8S_CHART)
K8S_TIMEOUT ?= 600s

# include OCI Images support
include .make/oci.mk

# include k8s support
include .make/k8s.mk

# include Helm Chart support
include .make/helm.mk

# Include Python support
include .make/python.mk

# include raw support
include .make/raw.mk

# include core make support
include .make/base.mk

# include your own private variables for custom deployment configuration
-include PrivateRules.mak

# pipeline job id
CI_JOB_ID ?= local

# TANGO_HOST connection to the Tango DS
TANGO_HOST ?= databaseds-tango-base:10000

# Domain used for naming Tango Device Servers, Emulator APIs, rabbitmq host, etc.
CLUSTER_DOMAIN ?= cluster.local

# W503: "Line break before binary operator." Disabled to work around a bug in flake8 where currently both "before" and "after" are disallowed.
PYTHON_SWITCHES_FOR_FLAKE8 = --ignore=DAR201,W503,E731

# F0002, F0010: Astroid errors. Not our problem.
# E0401: Import errors. Ignore for now until we figure out our actual project structure.
# E0611: Name not found in module. This occurs in our pipeline because the image we pull down uses an older version of Python; we should remove this immediately once we have our image building to CAR.
PYTHON_SWITCHES_FOR_PYLINT = --disable=E0401,E0611,F0002,F0010,E0001,E1101,C0114,C0115,C0116
PYTHON_SWITCHES_FOR_PYLINT_LOCAL = --disable=E0401,F0002,F0010,E1101,C0114,C0115,C0116

PYTHON_LINT_TARGET = tests/