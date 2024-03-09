# Домашнее задание к занятию «Инструменты Git»

### Цель задания

В результате выполнения задания вы:

* научитесь работать с утилитами Git;
* потренируетесь решать типовые задачи, возникающие при работе в команде. 

### Инструкция к заданию

1. Склонируйте [репозиторий](https://github.com/hashicorp/terraform) с исходным кодом Terraform.
2. Создайте файл для ответов на задания в своём репозитории, после выполнения прикрепите ссылку на .md-файл с ответами в личном кабинете.
3. Любые вопросы по решению задач задавайте в чате учебной группы.

------

## Задание

В клонированном репозитории:

1. Найдите полный хеш и комментарий коммита, хеш которого начинается на `aefea`.
Для поиска воспользовался командой
```
git log -s "aefea"
```
2. Ответьте на вопросы.

* Какому тегу соответствует коммит `85024d3`?
   85024d3 = v0.12.23
  ```
  git show 85024d3
  ```
* Сколько родителей у коммита `b8d720`? Напишите их хеши.
2 Родителя - их хеши 56cd7859e05c36c06b56d013b55a252d0bb7e158 9ea88f22fc6269854151c571162c5bcf958bee2b
  ```
  git show --pretty=%P b8d720
  ```
  
* Перечислите хеши и комментарии всех коммитов, которые были сделаны между тегами  v0.12.23 и v0.12.24.
   Команда
   ```
   git log v0.12.23..v0.12.24 --oneline
   ```
  Результат
  ```
   33ff1c03bb (tag: v0.12.24) v0.12.24
   b14b74c493 [Website] vmc provider links
   3f235065b9 Update CHANGELOG.md
   6ae64e247b registry: Fix panic when server is unreachable
   5c619ca1ba website: Remove links to the getting started guide's old location
   06275647e2 Update CHANGELOG.md
   d5f9411f51 command: Fix bug when using terraform login on Windows
   4b6d06cc5d Update CHANGELOG.md
   dd01a35078 Update CHANGELOG.md
   225466bc3e Cleanup after v0.12.23 release

  ```
  
* Найдите коммит, в котором была создана функция `func providerSource`, её определение в коде выглядит так: `func providerSource(...)` (вместо троеточия перечислены аргументы).
  Ответ - 8c928e83589d90a031f811fae52a81be7153e82f
  Команды 3
   ```
   git log -S"func providerSource" --oneline
   git grep "func providerSource" --oneline
   git log -L:providerSource:provider_source.go
   ```
* Найдите все коммиты, в которых была изменена функция `globalPluginDirs`.
  ```
     1)git log -S'globalPluginDirs' --source --oneline
   2)
   
   git grep "globalPluginDirs"
   
   commands.go:            GlobalPluginDirs: globalPluginDirs()
   plugins.go:func globalPluginDirs() []string {
   
   
   git log -s -L:globalPluginDirs:commands.go --oneline
   git log -s -L:globalPluginDirs:plugins.go --oneline
  ```

  
* Кто автор функции `synchronizedWriters`? 
```
 git log -S"func synchronizedWriters(" --pretty=format:'%h %an %ad %s' --reverse | head -n 1
 git log -S"func synchronizedWriters(" --pretty=format:'%h %an %ad %s' | tail -n 1
```

*В качестве решения ответьте на вопросы и опишите, как были получены эти ответы.*

---

### Правила приёма домашнего задания

В личном кабинете отправлена ссылка на .md-файл в вашем репозитории.

### Критерии оценки

Зачёт:

* выполнены все задания;
* ответы даны в развёрнутой форме;
* приложены соответствующие скриншоты и файлы проекта;
* в выполненных заданиях нет противоречий и нарушения логики.

На доработку:

* задание выполнено частично или не выполнено вообще;
* в логике выполнения заданий есть противоречия и существенные недостатки.
