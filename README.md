[![Build Status](https://travis-ci.org/open-io/ansible-role-openio-oio-event-agent.svg?branch=master)](https://travis-ci.org/open-io/ansible-role-openio-oio-event-agent)
# Ansible role `event_agent`

An Ansible role for oio-event-agent. Specifically, the responsibilities of this role are to:

- Install and configure

## Requirements

- Ansible 2.4+

## Role Variables


| Variable   | Default | Comments (type)  |
| :---       | :---    | :---             |
| `openio_event_agent_account_service_pipeline` | `list` | ... |
| `openio_event_agent_acct_update` | `true` | ... |
| `openio_event_agent_batch_size` | `500` | ... |
| `openio_event_agent_filter_account_update` | `dict` | ... |
| `openio_event_agent_filter_content_cleaner` | `dict` | ... |
| `openio_event_agent_filter_content_improve` | `dict` | ... |
| `openio_event_agent_filter_content_rebuild` | `dict` | ... |
| `openio_event_agent_filter_indexing` | `dict` | ... |
| `openio_event_agent_filter_logger` | `dict` | ... |
| `openio_event_agent_filter_volume_index` | `dict` | ... |
| `openio_event_agent_filter_noop` | `dict` | ... |
| `openio_event_agent_filter_quarantine` | `dict` | ... |
| `openio_event_agent_filter_replication` | `dict` | ... |
| `openio_event_agent_gridinit_dir` | `"/etc/gridinit.d/{{ openio_event_agent_namespace }}"` | ... |
| `openio_event_agent_gridinit_file_prefix` | `""` | ... |
| `openio_event_agent_location` | `"{{ ansible_hostname }}.{{ openio_event_agent_serviceid }}"` | ... |
| `openio_event_agent_namespace` | `"OPENIO"` | ... |
| `openio_event_agent_provision_only` | `false` | ... |
| `openio_event_agent_queue_url` | `"beanstalk://{{ ansible_default_ipv4.address }}:6014"` | ... |
| `openio_event_agent_rdir_update` | `true` | ... |
| `openio_event_agent_retries_per_second` | `30` | ... |
| `openio_event_agent_serviceid` | `"0"` | ... |
| `openio_event_agent_storage_chunk_deleted_pipeline` | `list` | ... |
| `openio_event_agent_storage_chunk_new_pipeline` | `list` | ... |
| `openio_event_agent_storage_container_deleted_pipeline` | `list` | ... |
| `openio_event_agent_storage_container_new_pipeline` | `list` | ... |
| `openio_event_agent_storage_container_state_pipeline` | `list` | ... |
| `openio_event_agent_storage_content_append_pipeline` | `list` | ... |
| `openio_event_agent_storage_content_broken_pipeline` | `list` | ... |
| `openio_event_agent_storage_content_deleted_pipeline` | `list` | ... |
| `openio_event_agent_storage_content_new_pipeline` | `list` | ... |
| `openio_event_agent_storage_content_perfectible_pipeline` | `[]` | ... |
| `openio_event_agent_tube` | `oio` | ... |

## Dependencies

No dependencies.

## Example Playbook

```yaml
- hosts: all
  become: true
  vars:
    NS: OPENIO
  roles:
    - role: repo
    - role: repo
      openio_repository_no_log: false
      openio_repository_products:
        sds:
          release: "18.10"
    - role: namespace
      openio_namespace_name: "{{ NS }}"
    - role: gridinit
      openio_gridinit_namespace: "{{ NS }}"
      openio_gridinit_per_ns: true
    - role: role_under_test
      openio_event_agent_namespace: "{{ NS }}"
      openio_event_agent_queue_url: "beanstalk://{{ ansible_default_ipv4.address }}:6014"
      openio_event_agent_storage_content_new_pipeline:
        - indexing
      openio_event_agent_storage_content_deleted_pipeline:
        - indexing
      openio_event_agent_filter_indexing:
        use: "egg:oio#webhook"
        endpoint: "http://192.168.1.2:8000/api/core/v1/namespaces/default/services/indexing/proxy/invoke"
      openio_event_agent_storage_content_perfectible_pipeline:
        - content_improve
```


```ini
[all]
node1 ansible_host=192.168.1.173
```

## Contributing

Issues, feature requests, ideas are appreciated and can be posted in the Issues section.

Pull requests are also very welcome.
The best way to submit a PR is by first creating a fork of this Github project, then creating a topic branch for the suggested change and pushing that branch to your own fork.
Github can then easily create a PR based on that branch.

## License

GNU AFFERO GENERAL PUBLIC LICENSE, Version 3

## Contributors

- [Cedric DELGEHIER](https://github.com/cdelgehier) (maintainer)
