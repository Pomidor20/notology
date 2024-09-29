### Начало
Количество слев указывается только лишь тех - которые занимают место

- 3 инструкции занимаю место в слоях - COPY RUN ADD
- Получить информацию о контейнере
  ```
  docker inspect name_container | jq # jq это вывод в json 
  ```
- Получить информацию по слоям
  ```
  docker history name_containet
  ```
- 
-----
http://wiki.rosalab.ru/ru/index.php/%D0%AD%D0%BA%D1%81%D0%BF%D0%BB%D1%83%D0%B0%D1%82%D0%B0%D1%86%D0%B8%D1%8F_Docker#:~:text=%D0%98%D0%BD%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%86%D0%B8%D1%8F%20ARG,-%D0%98%D0%BD%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%86%D0%B8%D1%8F%20ARG%20%D0%BF%D0%BE%D0%B7%D0%B2%D0%BE%D0%BB%D1%8F%D0%B5%D1%82&text=%D0%92%20%D0%BE%D1%82%D0%BB%D0%B8%D1%87%D0%B8%D0%B5%20%D0%BE%D1%82%20ENV%2D%D0%BF%D0%B5%D1%80%D0%B5%D0%BC%D0%B5%D0%BD%D0%BD%D1%8B%D1%85,%D0%BA%D0%BE%D0%BD%D1%82%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B5%20%D0%B2%D0%BE%20%D0%B2%D1%80%D0%B5%D0%BC%D1%8F%20%D0%B5%D0%B3%D0%BE%20%D0%B2%D1%8B%D0%BF%D0%BE%D0%BB%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F.
