### Тут буду писать по playbook















### Проверка playbook[^9]

```
ansible-lint my_playbook.yml
ansible-playbook имя playbook --syntax-check
```
### Блок по шаблоном jinja2 [^10]

```
Привет! Твой IP-адрес:
{% for ip_address in ansible_default_ipv4.addresses %}
  {{ ip_address }}
{% endfor %}
Ты зашел на {{ ansible_facts.hostname }}
Have a nice day, BOSS
```

-{% for ... %} и {% endfor %} обрамляют блок цикла, который перебирает IP-адреса.
-{{ ... }} используется для вставки значений переменных или выражений в вывод шаблона.
-Символ % в {% ... %} и {{ ... }} - это часть синтаксиса Jinja2, который позволяет вставлять и управлять переменными и логикой в шаблонах. Это помогает   генерировать динамический текст на основе данных, доступных в контексте выполнения, что полезно для создания конфигурационных файлов и других текстовых   файлов в Ansible.

========================================================  
https://github.com/ansible/ansible-examples

[^9]: https://docs.ansible.com/ansible/2.9/user_guide/playbooks_intro.html#linting-playbooks https://ansible.readthedocs.io/projects/lint/
[^10]: https://andreyex.ru/linux/ansible-shablony-jinja2/
