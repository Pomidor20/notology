# Домашнее задание к занятию «Запуск приложений в K8S»

### Цель задания

В тестовой среде для работы с Kubernetes, установленной в предыдущем ДЗ, необходимо развернуть Deployment с приложением, состоящим из нескольких контейнеров, и масштабировать его.

------

### Чеклист готовности к домашнему заданию

1. Установленное k8s-решение (например, MicroK8S).
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключённым git-репозиторием.

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Описание](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) Deployment и примеры манифестов.
2. [Описание](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) Init-контейнеров.
3. [Описание](https://github.com/wbitt/Network-MultiTool) Multitool.

## Решения 
команды из ДЗ
```
1.1
 kubectl apply -f ./deploy.yaml
 kubectl get pods -A -w
 kubectl describe deployments.apps nginx
 kubectl describe rs nginx-756cb7b4c7
 kubectl describe  pods/nginx-756cb7b4c7-q2rzj
 1.2
 kubectl scale deployment nginx --replicas 2
 kubectl apply -f svc.yaml
 kubectl describe service nginx-svc
 
 2
 kubectl logs nginx-deployment-865844fb5c-kg8tq wait-for-service

```
------

### Задание 1. Создать Deployment и обеспечить доступ к репликам приложения из другого Pod

1. Создать Deployment приложения, состоящего из двух контейнеров — nginx и multitool. Решить возникшую ошибку.
2. После запуска увеличить количество реплик работающего приложения до 2.
3. Продемонстрировать количество подов до и после масштабирования.
4. Создать Service, который обеспечит доступ до реплик приложений из п.1.
5. Создать отдельный Pod с приложением multitool и убедиться с помощью `curl`, что из пода есть доступ до приложений из п.1.

![](https://github.com/Pomidor20/notology/blob/main/Netology/22.k8s/22.3%20Deployment/pic/1.JPG)
![](https://github.com/Pomidor20/notology/blob/main/Netology/22.k8s/22.3%20Deployment/pic/2.JPG)
![](https://github.com/Pomidor20/notology/blob/main/Netology/22.k8s/22.3%20Deployment/pic/3.JPG)
![](https://github.com/Pomidor20/notology/blob/main/Netology/22.k8s/22.3%20Deployment/pic/1.2.JPG)
![](https://github.com/Pomidor20/notology/blob/main/Netology/22.k8s/22.3%20Deployment/pic/1.2.2.JPG)
![](https://github.com/Pomidor20/notology/blob/main/Netology/22.k8s/22.3%20Deployment/pic/1.2.3.JPG)
![](https://github.com/Pomidor20/notology/blob/main/Netology/22.k8s/22.3%20Deployment/pic/1.2.4.JPG)
------

### Задание 2. Создать Deployment и обеспечить старт основного контейнера при выполнении условий

1. Создать Deployment приложения nginx и обеспечить старт контейнера только после того, как будет запущен сервис этого приложения.
2. Убедиться, что nginx не стартует. В качестве Init-контейнера взять busybox.
3. Создать и запустить Service. Убедиться, что Init запустился.
4. Продемонстрировать состояние пода до и после запуска сервиса.
![](https://github.com/Pomidor20/notology/blob/main/Netology/22.k8s/22.3%20Deployment/pic/_2.JPG)
------





### Правила приема работы

1. Домашняя работа оформляется в своем Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl` и скриншоты результатов.
3. Репозиторий должен содержать файлы манифестов и ссылки на них в файле README.md.

------
