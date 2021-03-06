
Функция GetCustomersListGetCustomersList(Запрос)
	
	//1. формируем массив клиентов для отправки
	Клиенты = Справочники.Контрагенты.Выбрать();
	
	МассивКлиентов = Новый Массив;
	
	Пока Клиенты.Следующий() Цикл
		
		Если Клиенты.ЭтоГруппа Тогда
			Продолжить;
		КонецЕсли;
		
		ДанныеКлиента = Новый Структура;
		ДанныеКлиента.Вставить("Code", Клиенты.Код);
		ДанныеКлиента.Вставить("Name", Клиенты.Наименование);
		ДанныеКлиента.Вставить("Phone", Клиенты.Телефон);
		ДанныеКлиента.Вставить("Email", Клиенты.ЭлектроннаяПочта);
		МассивКлиентов.Добавить(ДанныеКлиента);
		
	КонецЦикла; 
	
	//2. сериализуем массив клиентов в JSON
	ЗаписьJSON = Новый ЗаписьJSON;
	ЗаписьJSON.УстановитьСтроку();
	ЗаписатьJSON(ЗаписьJSON, МассивКлиентов);
	СтрокаДляОтвета = ЗаписьJSON.Закрыть();
	
	//3. формируем ответ
	Ответ = Новый HTTPСервисОтвет(200);
	Ответ.Заголовки.Вставить("Content-type", "application/JSON; charset=utf-8");
	Ответ.УстановитьТелоИзСтроки(СтрокаДляОтвета, КодировкаТекста.UTF8, ИспользованиеByteOrderMark.НеИспользовать);
	
	Возврат Ответ;
	
КонецФункции

Функция GetCustomersInfoGetCustomerInfo(Запрос)
	
	//1.получим из запроса параметр CustomerCode и найдем по коду контрагента
	КодКлиента = Запрос.ПараметрыURL["CustomerCode"];
	Клиент = Справочники.Контрагенты.НайтиПоКоду(КодКлиента);
	
	Если НЕ ЗначениеЗаполнено(Клиент) Тогда
		
		//2. если клиент не найден, то будем возвращать Статус-код 204 No content
		Ответ = Новый HTTPСервисОтвет(204); //No content
		
	Иначе
		
		//3. заполним структуру данных о клиенте
		ДанныеКлиента = Новый Структура;
		ДанныеКлиента.Вставить("Code", Клиент.Код);
		ДанныеКлиента.Вставить("Name", Клиент.Наименование);
		ДанныеКлиента.Вставить("Phone", Клиент.Телефон);
		ДанныеКлиента.Вставить("Email", Клиент.ЭлектроннаяПочта);
		
		//4. сериализуем данные о клиенте в JSON
		ЗаписьJSON = Новый ЗаписьJSON;
		ЗаписьJSON.УстановитьСтроку();
		ЗаписатьJSON(ЗаписьJSON, ДанныеКлиента);
		СтрокаДляОтвета = ЗаписьJSON.Закрыть();
		
		//5. сформируем ответ
		Ответ = Новый HTTPСервисОтвет(200);
		Ответ.Заголовки.Вставить("Content-type", "application/JSON; charset=utf-8");
		Ответ.УстановитьТелоИзСтроки(СтрокаДляОтвета, КодировкаТекста.UTF8, ИспользованиеByteOrderMark.НеИспользовать);
	
	КонецЕсли;
	
	Возврат Ответ;
	
КонецФункции

Функция PostCustomerInfoPostCustomerInfo(Запрос)
	
	//1.получаем тело запроса
	Сообщение = Запрос.ПолучитьТелоКакСтроку("UTF-8");
	
	//2.десериализуем данные о клиенте из JSON
	ЧтениеJSON = Новый ЧтениеJSON;
	ЧтениеJSON.УстановитьСтроку(Сообщение);
	ДанныеКлиента = ПрочитатьJSON(ЧтениеJSON);
	ЧтениеJSON.Закрыть();
	
	//3.ищем клиента
	КодКлиента = "";
	Если ДанныеКлиента.Свойство("Код", КодКлиента) Тогда
		Клиент = Справочники.Контрагенты.НайтиПоКоду(КодКлиента);
		Если НЕ ЗначениеЗаполнено(Клиент) Тогда
			Клиент = Справочники.Контрагенты.СоздатьЭлемент();
		Иначе
			Клиент = Клиент.ПолучитьОбъект();
		КонецЕсли; 
		ЗаполнитьЗначенияСвойств(Клиент, ДанныеКлиента);
		Клиент.Записать();
		Ответ = Новый HTTPСервисОтвет(200);
	Иначе
		//4.если нет свойства Код, то что-то не то передали
		Ответ = Новый HTTPСервисОтвет(402);
		Возврат Ответ;
	КонецЕсли; 
	
	Возврат Ответ;
	
КонецФункции
