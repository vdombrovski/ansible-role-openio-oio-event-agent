[![Build Status](https://travis-ci.org/open-io/ansible-role-openio-oio-event-agent.svg?branch=master)](https://travis-ci.org/open-io/ansible-role-openio-oio-event-agent)
# Ansible role `event_agent`

An Ansible role for oio-event-agent. Specifically, the responsibilities of this role are to:

- Install and configure

## Requirements

- Ansible 2.4+

## Role Variables


| Variable   | Default | Comments (type)  |
| :---       | :---    | :---             |
| `openio_event_agent_account_service_pipeline` | `list` | List of middlewares involved in `account.services` |
| `openio_event_agent_filter_account_update` | `dict` | Options of `account_update` filter |
| `openio_event_agent_filter_content_cleaner` | `dict` | Options of `content_cleaner` filter |
| `openio_event_agent_filter_content_improve` | `dict` | Options of `content_improve` filter |
| `openio_event_agent_filter_content_rebuild` | `dict` | Options of `content_rebuild` filter |
| `openio_event_agent_filter_logger` | `dict` | Options of `logger` filter |
| `openio_event_agent_filter_volume_index` | `dict` | Options of `volume_index` filter |
| `openio_event_agent_filter_noop` | `dict` | Options of `noop` filter |
| `openio_event_agent_filter_quarantine` | `dict` | Options of `quarantine` filter |
| `openio_event_agent_filter_replication` | `dict` | Options of `replication` filter |
| `openio_event_agent_gridinit_dir` | `"/etc/gridinit.d/{{ openio_event_agent_namespace }}"` | Path to copy the gridinit conf |
| `openio_event_agent_gridinit_file_prefix` | `""` | Maybe set it to {{ openio_ecd_namespace }}- for old gridinit's style |
| `openio_event_agent_location` | `"{{ ansible_hostname }}.{{ openio_event_agent_serviceid }}"` | Location |
| `openio_event_agent_namespace` | `"OPENIO"` | Namespace |
| `openio_event_agent_provision_only` | `false` | Provision only without restarting services |
| `openio_event_agent_queue_url` | `"beanstalk://{{ ansible_default_ipv4.address }}:6014"` | URL of queue service |
| `openio_event_agent_serviceid` | `"0"` | ID in gridinit |
| `openio_event_agent_storage_chunk_deleted_pipeline` | `list` | List of middlewares involved in `storage.chunk.deleted` |
| `openio_event_agent_storage_chunk_new_pipeline` | `list` | List of middlewares involved in `storage.chunk.new` |
| `openio_event_agent_storage_container_deleted_pipeline` | `list` | List of middlewares involved in `storage.container.deleted` |
| `openio_event_agent_storage_container_new_pipeline` | `list` | List of middlewares involved in `storage.container.new` |
| `openio_event_agent_storage_container_state_pipeline` | `list` | List of middlewares involved in `storage.container.state` |
| `openio_event_agent_storage_content_append_pipeline` | `list` | List of middlewares involved in `storage.content.append` |
| `openio_event_agent_storage_content_broken_pipeline` | `list` | List of middlewares involved in `storage.content.broken` |
| `openio_event_agent_storage_content_deleted_pipeline` | `list` | List of middlewares involved in `storage.content.deleted` |
| `openio_event_agent_storage_content_new_pipeline` | `list` | List of middlewares involved in `storage.content.new` |
| `openio_event_agent_storage_content_drained_pipeline` | `list` | List of middlewares involved in `storage.content.drained` |
| `openio_event_agent_storage_content_update_pipeline` | `list` | List of middlewares involved in `storage.content.update` |
| `openio_event_agent_storage_content_perfectible_pipeline` | `[]` | List of middlewares involved in `storage.content.perfectible` |
| `openio_event_agent_tube` | `oio` | Tube used in queue service |
| `openio_event_agent_workers` | `"{{ ansible_processor_vcpus / 2 }}"` | Number of workers  |

## Dependencies

No dependencies.

## Example Playbook

```yaml
- hosts: all
  become: true
  vars:
    NS: OPENIO
  roles:
    - role: users
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
    - role: oio-event-agent
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
