#! /usr/bin/env bats

# Variable SUT_IP should be set outside this script and should contain the IP
# address of the System Under Test.

# Tests

#@test 'NAME - test1' {
#  run bash -c "docker exec -ti ${SUT_ID} cat /etc/foo"
#  echo "output: "$output
#  echo "status: "$status
#  [[ "${status}" -eq "0" ]]
#  [[ "${output}" =~ 'String in the output1' ]]
#  [[ "${output}" =~ 'String in the output2' ]]
#}

@test 'Test configuration file paths' {
    BASE_PATH="/etc/oio/sds/TRAVIS/oio-event-agent-0"

    run bash -c "docker exec -ti ${SUT_ID} stat ${BASE_PATH}/oio-event-agent-0.conf"
    echo "status: "$status
    [[ "${status}" -eq "0" ]]

    run bash -c "docker exec -ti ${SUT_ID} stat / ${BASE_PATH}/oio-event-handlers.conf"
    echo "status: "$status
    [[ "${status}" -eq "0" ]]

    run bash -c "docker exec -ti ${SUT_ID} stat  ${BASE_PATH}/oio-event-agent-0.1.conf"
    echo "status: "$status
    [[ "${status}" -eq "0" ]]

    run bash -c "docker exec -ti ${SUT_ID} stat ${BASE_PATH}/oio-event-handlers-delete.conf"
    echo "status: "$status
    [[ "${status}" -eq "0" ]]
}

@test 'Test gridinit services' {
    run bash -c "docker exec -ti ${SUT_ID} gridinit_cmd status TRAVIS-oio-event-agent-0 | grep UP"
    echo "status: "$status
    [[ "${status}" -eq "0" ]]

    run bash -c "docker exec -ti ${SUT_ID} gridinit_cmd status TRAVIS-oio-event-agent-0.1 | grep UP"
    echo "status: "$status
    [[ "${status}" -eq "0" ]]
}
