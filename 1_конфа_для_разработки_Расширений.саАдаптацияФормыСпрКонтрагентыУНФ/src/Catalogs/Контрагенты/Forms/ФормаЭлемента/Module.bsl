
&НаСервере
Функция СтранаРегистрацииБеларусь()

	СтранаБеларусь = Ложь;
	
	Если ЗначениеЗаполнено(Объект.СтранаРегистрации) Тогда
		
		Беларусь = Справочники.СтраныМира.НайтиПоКоду("112");
		Если Объект.СтранаРегистрации = Беларусь Тогда
			СтранаБеларусь = Истина;
		КонецЕсли; 
	
	КонецЕсли; 

	Возврат	СтранаБеларусь;
	
КонецФункции // СтранаРегистрацииБеларусь()

&НаКлиенте
Процедура саДляРБ_ПриОткрытииПосле(Отказ)
	
	Если СтранаРегистрацииБеларусь() Тогда
		//Элементы.КодПоОКПО.Видимость = Истина; //тол+ не сохраняет реквизит при записи
		Элементы.ИНН.Заголовок = "УНП";	
		Элементы.ИНН.ЦветТекстаЗаголовка = WebЦвета.Синий;
	Иначе	
		Элементы.ИНН.Заголовок = "ИНН";	
		Элементы.ИНН.ЦветТекстаЗаголовка = WebЦвета.Черный;
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура саДляРБ_СтранаРегистрацииПриИзмененииПосле(Элемент)
	
	Если СтранаРегистрацииБеларусь() Тогда
		//Элементы.КодПоОКПО.Видимость = Истина; //тол+ не сохраняет реквизит при записи
		Элементы.ИНН.Заголовок = "УНП";
		Элементы.ИНН.ЦветТекстаЗаголовка = WebЦвета.Синий;
	Иначе	
		Элементы.ИНН.Заголовок = "ИНН";	
		Элементы.ИНН.ЦветТекстаЗаголовка = WebЦвета.Черный;
	КонецЕсли; 
	
КонецПроцедуры
