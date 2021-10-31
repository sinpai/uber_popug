### UberPopug Inc async arch project

Initial schema for 0 week home work - ![schema](https://monosnap.com/image/EQvwn8OmPPgJ3aSSv4RZtuznvbmesQ)

Event storming - ![board](https://excalidraw.com/#json=6580356576706560,QXTBIUrFuRfuups21INOAw), ![screen](https://monosnap.com/image/YGjAdm9PjJF6MkQ2opwo476cJEkP0w)

Domain model - ![board](https://excalidraw.com/#json=5964305358913536,ImhruDEcT9AgagPl9GE9ww), ![screen](https://monosnap.com/image/Q4LTZKzvYP4ozSEB4x1nvETAhUR3mt)

> Определить, какие общие данные нужны для разных доменов и как связаны данные между разными доменами.

Общие данные между всеми доменами - таблица Users и токен авторизации

> Разобраться, какие сервисы, кроме тудушника, будут в нашей системе и какие между ними могут быть связи (как синхронные, так и асинхронные).

В системе будет 4 сервиса:
- auth
- tasks/analytics (2 домена: tasks и analytics)
- accounting
- mail
+\- api ?

**Сервис auth:**
синхронные связи:
- api

асинхронные связи:
- User CUD

**Сервис tasks**
синхронные связи:
- api

асинхронные связи:
- task.completed > **accounting**
- tasks.reassigned > **accounting**
- Task CUD

**Сервис accounting**
синхронные связи:
- api

асинхронные связи:
- **tasks** > task.completed
- **tasks** > task.reassigned
- accounts.withdraw > **mail**
- **mail** < mail.withdrawals_sent

**Сервис mail**
асинхронные связи:
- **acounting** > accounts.withdraw

> Определить все бизнес события, необходимые для работы системы. Отобразить кто из сервисов является продьюсером, а кто консьюмером бизнес событий.

Бизнес события:
- tasks.reassigned (tasks > analytics)
- task.completed (tasks > analytics)
- accounts.withdraw (analytics > mail)
- mail.withdrawals_sent (mail > analytics)
- Finish day - accounts.updated (task > task)
- Create withdrawal transaction (task > task)

> Выписать все CUD события и какие данные нужны для этих событий, которые необходимы для работы системы. Отобразить кто из сервисов является продьюсером, а кто консьюмером CUD событий.

CUD события:
- User CUD (User > Tasks, Accounting, Mail)
- Tasks CUD (-)
- Transactions CUD (-)
- Account Update (Account > Mail)
