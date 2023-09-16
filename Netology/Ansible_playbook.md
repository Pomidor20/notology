### Тут буду писать по playbook








#### Как работать с фактами on playbook 
https://www.redhat.com/sysadmin/playing-ansible-facts
```
Ansible факты и тип данных
Факты Ansible хранятся в формате JSON и могут быть разделены на три основные категории:

Список : хранит список элементов, а сохраненная информация записывается в квадратных скобках [] . В основном это факты, которые могут иметь несколько значений, например, system_capablities. Доступ к списку осуществляется с помощью квадратных скобок и указания индекса.

    ansible_facts["all_ipv6_addresses"][1]
    ansible_facts["all_ipv6_addresses"][2]

Словарь : хранит данные в виде набора пар ключ-значение, а информация хранится внутри фигурных скобок {} . В основном это факты, внутри которых есть подфакты, например: memory_mb. Доступ к словарю осуществляется с помощью оператора точки.

    ansible_facts.memory_mb.real
Ansible Unsafe Text : переменные этого типа не имеют подчастей и хранят данные напрямую, например machine. Доступ к Ansible Unsafe Text можно получить напрямую, используя имя факта.

    ansible_facts["machine"]
Используйте фильтр type_debug , чтобы проверить тип данных на наличие фактов Ansible.

- hosts: all
  tasks:
  - debug:
      var: ansible_facts["all_ipv6_addresses"]|type_debug
  - debug:
      var: ansible_facts["memory_mb"]|type_debug
  - debug:
      var: ansible_facts["machine"]|type_debug
```


#### Передать результаты одного task в другой.
команда register
пример
```
      - name: "find recurse files"
        tags: find
        ansible.builtin.find:
          path: /etc/update-motd.d/
          recurse: true
        register: rm_files
      - name: "remove files by env"
        ansible.builtin.file:
          path: {{ rm_files.path }}
          state: absent     
```
В одном Джобе результат кладем в переменную rm_files,второй джобой удаляем все файты от туда.



#### Проверка playbook[^9]

```
ansible-lint my_playbook.yml
ansible-playbook имя playbook --syntax-check
```

#### Модул  проверки условий
__assert__
```
- name: Ensure a specific file exists
  assert:
    that:
      - "ansible_distribution == 'Ubuntu'"
      - "ansible_architecture == 'x86_64'"
      - "ansible_fqdn == 'myserver.example.com'"
    msg: "The conditions for file existence are not met."
```
> [!NOTE]  
> В этом примере задача с модулем assert проверяет три условия:
> 1. ansible_distribution должен быть равен "Ubuntu".
> 2. ansible_architecture должен быть равен "x86_64".
> 3. ansible_fqdn должен быть равен "myserver.example.com".
>  Если хотя бы одно из этих условий не выполняется, задача завершается ошибкой с указанным сообщением "The conditions for file existence are not met."



### Блок по шаблоном jinja2 [^10]
https://jinja.palletsprojects.com/en/2.11.x/templates/
#### Циклы
```
{% for i in range(1,11) %}
	Number {{ i }}
{% endfor %}


Привет! Твой IP-адрес:
{% for ip_address in ansible_default_ipv4.addresses %}
  {{ ip_address }}
{% endfor %}
Ты зашел на {{ ansible_facts.hostname }}
Have a nice day, BOSS
```

- {% for ... %} и {% endfor %} обрамляют блок цикла, который перебирает IP-адреса.  
- {{ ... }} используется для вставки значений переменных или выражений в вывод шаблона.  
- Символ % в {% ... %} и {{ ... }} - это часть синтаксиса Jinja2, который позволяет вставлять и управлять переменными и логикой в шаблонах. Это         помогает   генерировать динамический текст на основе данных, доступных в контексте выполнения, что полезно для создания конфигурационных файлов и     других текстовых   файлов в Ansible.  

========================================================  
https://github.com/ansible/ansible-examples
https://docs.ansible.com/ansible/latest/collections/ansible/builtin/template_module.html#ansible-collections-ansible-builtin-template-module
[^9]: https://docs.ansible.com/ansible/2.9/user_guide/playbooks_intro.html#linting-playbooks https://ansible.readthedocs.io/projects/lint/
[^10]: https://andreyex.ru/linux/ansible-shablony-jinja2/
