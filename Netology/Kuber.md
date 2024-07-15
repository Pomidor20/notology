Основные компоненты кластера:

etcd - база данных k8s.Должна быть установлена на каждом Control Plane - Мастер ноду..Хранит все всю информацию о кластере.Является statefull.Для выбора главное в кластере используется алгоритм RAFT.

api-server - Центральный компонент через который мы общаемся с кубером.Является stateless.Единственный кто общается с etcd.Занимается Аунтификацией и Авториацией.


Controller manager - Менеджер всех контроллеров.Больше 10-ка контроллеров.Также генерирует манифесты подов.Самые популярыне:  
	- Node controller.Держит связь с Нодами кластера,если нода не отвечает - переносит на другой контроллер.Общение между Kubelet (это агент установленный на ноде) и node и Node контроллерами происходит только через api-server.  
	- Replicaset controller	- обращается в api-server ,видит созданные Replicaset ,реализуетя их процедуру создания.ReplicaSet гарантирует, что определенное количество экземпляров подов (Pods) будет запущено в кластере Kubernetes в любой момент времени.  
	- endpoints controller - автоматизация создания эндпоинтов для сервисов  
(связь между подом и его сервисом)  
	- Garbage Collector, GC (сборщик мусора) - ищет и удаляет мусор,который в кластере больше не нужен (например, старые реплики, которые превышают установленный лимит  

Sheduler - Запускается по 1 на каждую мастер ноду.Планирует на какую ноду отправится нагрузка (отправляет поды на ноды).Обращается к api servery за манифестами подов и назначает их на ноды.    
		- QoS (quality of service)   
		- Affinity и Anti-affinity   
		- Requests и Limits   
		- Priority Class (preemption)
 

kubelet – агент, работающий на узле кластера   
	- Работает на каждой ноде (и мастеры и воркеры)   
	- Не запускается в докере, работает как процесс на хосте   
	(systemctl status kubelet)   
	- Отдает команды docker daemon через docker api (docker run,напр.)   
	- фактически реализует запуск подов на узле   
	- Обеспечивает проверки liveness probe, readiness probe, startup probe   
		- Liveness probe – используется для определения, когда контейнер необходимо перезапустить.Проверка по запросу?   
		- Readiness probe – используется для проверки, доступен ли модуль в течение всего жизненного цикла. В отличие от liveness probe, в случае сбоя проверки останавливается только трафик к модулю , но перезапуска не происходит   
		- Startup probe – используется для проверки, что приложение в контейнере было запущено. Если проба настроена, то liveness и readiness проверки блокируются, до того как проба пройдет успешно. Проба при старте.    

kube-proxy – сетевой прокси, работающий на каждом узле в кластере   

	- Взаимодействует с api-server   
	- Устанавливается на всех нодах   
	- Управляет сетевыми правилами на нодах   
	- Запускается в контейнере   
	- Некоторые cni-плагины забирают работу kube-proxy себе	   

Базовые компоненты:   

	-Nodes – виртуальная (физическая) машина, на мощностях которой запущены контейнеры.   
	-Pods – базовые модули управления приложениями, состоящие из одного или нескольких контейнеров.   
	-Volume – ресурс, позволяющий одновременно запускать несколько контейнеров.   
	-Kube-Proxy – комплекс из прокси-сервера и модуля балансировки нагрузки, позволяющий маршрутизировать входящий трафик под конкретный контейнер Pods.   
	-Kubelet – транслятор статусов Pods на узле и контроллер корректности работы контейнера и образа в целом.   
	- cri (движок процесса контейнеризации)   
	- cni (сетевые плагины).Calico   
	- dns (k8s-совместимые dns-серверы).CoreDNS -cubedns   
	- ccm (controller-manager для облачных решений).Контроллеры облаков.   
	- Taints - это свойство нод, которое позволяет поду выбирать необходимую ноду.
 	- Tolerations применяеются к подам и позволяют (но не требуют) планировать модули на нодах с соответствующим Taints.


Команды 
- получить описание пода
```
Kubectl describe pod
```




Команды kubernates
- Получить список NOd
```
 kubectl get nodes
```

- Получить все пространства имен
```
kubectl get ns
```

- Получить все поды во всех namespaces
```
kubectl get po -A
```
- Получить ip адреса подов
```
kubectl get pod -o wide
```

Что такое
kubectl get endpoints 

- Пропатчить (изменить конфигурацию) через команду на горячую
kubectl patch service my-app -p '{"spec": {"selector":{"version ":"v2.0.0"}}}'

## HELM
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor |  tee /usr/share/keyrings/helm.gpg > /dev/null
apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" |  tee /etc/apt/sources.list.d/helm-stable-debian.list
apt-get update
apt-get install helm

kubectl get ingress -n ingress-nginx
helm upgrade --install ingress-nginx /mnt/ingress-nginx/ -n ingress-nginx

 kubectl get secrets sh.helm.release.v1.ingress-nginx.v1 -n ingress-nginx -o yaml
 
  helm template helm-test /mnt/helm-test/  -n helm-test

### ПОЛЕЗНВЕ КОМАНДЫ
- Посмотреть все установленные чарт
  ```
  helm list --all-namespaces
  ```
 
- 

---
## POD
Создание и описание POD
```
apiVersion: v1
kind: Pod                                            # 1
metadata:
  name: sa-frontend                                  # 2
spec:                                                # 3
  containers:
    - image: rinormaloku/sentiment-analysis-frontend # 4
      name: sa-frontend                              # 5
      ports:
        - containerPort: 80
```
Kind: задаёт вид ресурса Kubernetes, который мы хотим создать. В нашем случае это Pod.
Name: имя ресурса. Мы назвали его sa-frontend.
Spec: объект, который описывает нужное состояние ресурса. Самое важное свойство здесь — это массив контейнеров.
Image: образ контейнера, который мы хотим запустить в данном поде.
Name: уникальное имя для контейнера, находящегося в поде.
ContainerPort: порт, который прослушивает контейнер. Этот параметр можно считать указанием для того, кто читает этот файл (если этот параметр опустить, это не ограничит доступ к порту).
