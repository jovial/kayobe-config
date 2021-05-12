# Enter config overrides in here

OPENSTACK_SERIES=train
KAYOBE_URI=https://github.com/RSE-Cambridge/kayobe
KAYOBE_BRANCH=cumulus/train

# Don't use upper constraints when installing kayobe
KAYOBE_PIP_INSTALL_ARGS=""

# Train: For Ensure the image cache directory exists which looks up USER in environment
export USER=stack

# TODO: Push to kayobe-automation. Might be nice to try and use value from kayobe-env.
KAYOBE_ENVIRONMENT="$(< ${KAYOBE_AUTOMATION_CONFIG_PATH}/../.environment)"

# NOTE: could dynamically switch this based on environment
KAYOBE_AUTOMATION_TEMPEST_CONF_OVERRIDES="${KAYOBE_AUTOMATION_CONFIG_PATH}/tempest/tempest-${KAYOBE_ENVIRONMENT}.overrides.conf"

# See: https://github.com/stackhpc/docker-rally/blob/master/bin/rally-verify-wrapper.sh for a full list of tempest parameters that can be overriden.
# You can override tempest parameters like so:
export TEMPEST_CONCURRENCY=2
# Specify single test whilst experimenting
#export TEMPEST_PATTERN="${TEMPEST_PATTERN:-tempest.api.compute.servers.test_create_server.ServersTestJSON.test_host_name_is_same_as_server_name}"

if [ "$KAYOBE_ENVIRONMENT" == "aio" ]; then
  # Seem to get servers failing to spawn with higher concurrency
  export TEMPEST_CONCURRENCY=1
fi
