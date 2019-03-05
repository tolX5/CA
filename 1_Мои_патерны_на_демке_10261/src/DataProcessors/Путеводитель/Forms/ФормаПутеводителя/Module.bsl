
&НаКлиенте
Перем ВременнаяСсылка;

&НаСервере
Функция СформироватьHTMLПутеводителя(Раздел)

	Перем КорневойЭлемент;

	Если НЕ Раздел = "" Тогда

		ДокументРаздела = Обработки.Путеводитель.ПолучитьМакет(Раздел).ПолучитьДокументHTML();
		КорневойЭлемент = ДокументРаздела.Тело;

	Иначе;

		КорневойЭлемент = Обработки.Путеводитель.ПолучитьМакет("ГлавнаяСтраница").ПолучитьДокументHTML();
		МенюРазделов = КорневойЭлемент.ПолучитьЭлементПоИдентификатору("ГлавноеМеню");
#Если МобильноеПриложениеСервер Тогда
		// На мобильном устройстве жалко места под поковые планки	
		ПраваяПанель = КорневойЭлемент.ПолучитьЭлементПоИдентификатору("Правая");
		ЛеваяПанель = КорневойЭлемент.ПолучитьЭлементПоИдентификатору("Левая");
		Центр = КорневойЭлемент.ПолучитьЭлементПоИдентификатору("Центр");
		ПраваяПанель.Ширина = "0";
		ЛеваяПанель.Ширина = "0";
		Центр.Ширина = "100%";
#КонецЕсли

		Для Сч = 0 По РазделыКонфигурации.Количество() - 1 Цикл

			ДанныеРаздела = РазделыКонфигурации.Получить(Сч);
			СтрТ = КорневойЭлемент.СоздатьЭлемент("tr");
			СтрТ.УстановитьАтрибут("style", "padding: 3px");
			КолТ = КорневойЭлемент.СоздатьЭлемент("td");
			СтрТ.ДобавитьДочерний(КолТ);
			МенюРазделов.ДобавитьДочерний(СтрТ);
			Ссылка = КорневойЭлемент.СоздатьЭлемент("a");
			Ссылка.УстановитьАтрибут("style", "color: #000000; text-decoration: none;");
			Ссылка.Гиперссылка = "#" + Сч;
			Ссылка.Идентификатор = ДанныеРаздела.Название;
			КолТ.ДобавитьДочерний(Ссылка);
			Текст = КорневойЭлемент.СоздатьТекстовыйУзел(ДанныеРаздела.Описание);
			Ссылка.ДобавитьДочерний(Текст);

		КонецЦикла;

	КонецЕсли;

	ЗапиcьHTML = Новый ЗаписьHTML;
	ЗапиcьHTML.УстановитьСтроку();
	ЗаписьDOM = Новый ЗаписьDOM;
	ЗаписьDOM.Записать(КорневойЭлемент, ЗапиcьHTML);

	Возврат ЗапиcьHTML.Закрыть();

КонецФункции

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Для Сч = 1 По Метаданные.Обработки.Путеводитель.Макеты.Количество() - 1 Цикл

		МетД = Метаданные.Обработки.Путеводитель.Макеты.Получить(Сч);
		Стр = РазделыКонфигурации.Добавить();
		Стр.Название = МетД.Имя;
		Стр.Описание = МетД.Синоним;

	КонецЦикла;

	ПолеHTML = СформироватьHTMLПутеводителя("");
	
	ТекущийПользователь = ПользователиИнформационнойБазы.ТекущийПользователь();
	Если ТекущийПользователь.Роли.Содержит(Метаданные.Роли.Администратор) Тогда
		Элементы.ДекорацияЕслиНеАдминистратор.Видимость = Ложь;
	Иначе
		Элементы.ДекорацияЕслиНеАдминистратор.Видимость = Истина;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Функция ПолучитьИндексРаздела(Раздел)

	Для Сч = 0 По РазделыКонфигурации.Количество() - 1 Цикл

		ДанныеРаздела = РазделыКонфигурации.Получить(Сч);

		Если ДанныеРаздела.Название = Раздел Тогда

			Возврат Сч;

		КонецЕсли;

	КонецЦикла;

	Возврат -1;

КонецФункции

&НаКлиенте
Процедура ПоказатьРаздел(Документ, Раздел)

	СодержимоеРаздела = СформироватьHTMLПутеводителя(Раздел);
	ЭлементHTML = Документ.getElementById("ПолеИнформации");
	ЭлементHTML.innerHTML = СодержимоеРаздела;
	Якорь = Документ.getElementById(Раздел);
	// В зависимости от типа браузера надо обращаться к разным свойствам
	Если НЕ ВременнаяСсылка = Неопределено Тогда
		Если Якорь.parentElement = Неопределено Тогда
			ВременнаяСсылка.parentNode.style.backGroundColor = "#FFFFFF";
		Иначе
			ВременнаяСсылка.parentElement.style.backGroundColor = "#FFFFFF";
		КонецЕсли;
	КонецЕсли;
	ВременнаяСсылка = Якорь;
	Если Якорь.parentElement = Неопределено Тогда
		Якорь.parentNode.style.backGroundColor = "#FFFFD5";
	Иначе
		Якорь.parentElement.style.backGroundColor = "#FFFFD5";
	КонецЕсли;

	Индекс = ПолучитьИндексРаздела(Раздел);

	СтрелкаЛев = Документ.getElementById("СтрелкаЛев");
	СтрелкаЛев.href = "#" + Строка(Индекс - 1);
	СтрелкаЛев.style.display = "";
	Если Индекс - 1 < 0 Тогда
		СтрелкаЛев.style.display = "none";
	КонецЕсли;
	
	СтрелкаПрав = Документ.getElementById("СтрелкаПрав");
	СтрелкаПрав.href = "#" + Строка(Индекс + 1);
	СтрелкаПрав.style.display = "";
	Если Индекс + 1 > РазделыКонфигурации.Количество() -1 Тогда
		СтрелкаПрав.style.display = "none";
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПолеHTMLПриНажатии(Элемент, ДанныеСобытия, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;	
	ТекущийДокумент = ДанныеСобытия.Document;
	
#Если МобильныйКлиент Тогда
		
	Позиция = Найти(ДанныеСобытия.Href, "ОткрытьФорму=");

	Если Позиция > 0 Тогда
		ОткрытьФорму(Сред(ДанныеСобытия.Href, Позиция + 13));
	КонецЕсли;

	Позиция = Найти(ДанныеСобытия.Href, "ОткрытьСправку=");

	Если Позиция > 0 Тогда
		ОткрытьСправку(Сред(ДанныеСобытия.Href, Позиция + 15));
	КонецЕсли;
	
	Позиция = Найти(ДанныеСобытия.Href, "ОткрытьСсылку=");

	Если Позиция > 0 Тогда
		ПерейтиПоНавигационнойСсылке(Сред(ДанныеСобытия.Href, Позиция + 14));
	КонецЕсли;

	Позиция = Найти(ДанныеСобытия.Href, "#");
	Если Позиция > 0 Тогда
		Индекс = Число(Сред(ДанныеСобытия.Href, Позиция + 1));
		ПоказатьРаздел(ТекущийДокумент, РазделыКонфигурации[Индекс].Название);
	КонецЕсли;
			
#Иначе
	
	Если НЕ ДанныеСобытия.Anchor = Неопределено Тогда

		Если ДанныеСобытия.Anchor.protocol = "v8:" Тогда

			Позиция = Найти(ДанныеСобытия.Href, "ОткрытьФорму=");

			Если Позиция > 0 Тогда
				ОткрытьФорму(Сред(ДанныеСобытия.Href, Позиция + 13));
			КонецЕсли;

			Позиция = Найти(ДанныеСобытия.Href, "ОткрытьСправку=");

			Если Позиция > 0 Тогда
				ОткрытьСправку(Сред(ДанныеСобытия.Href, Позиция + 15));
			КонецЕсли;
			
			Позиция = Найти(ДанныеСобытия.Href, "ОткрытьСсылку=");

			Если Позиция > 0 Тогда
				ПерейтиПоНавигационнойСсылке(Сред(ДанныеСобытия.Href, Позиция + 14));
			КонецЕсли;
			
		ИначеЕсли ДанныеСобытия.Anchor.id = "СтрелкаЛев" Тогда

			Позиция = Найти(ДанныеСобытия.Href, "#");
			Индекс = Число(Сред(ДанныеСобытия.Href, Позиция + 1));
			ПоказатьРаздел(ТекущийДокумент, РазделыКонфигурации[Индекс].Название);

		ИначеЕсли ДанныеСобытия.Anchor.id = "СтрелкаПрав" Тогда

			Позиция = Найти(ДанныеСобытия.Anchor.href, "#");			
			Индекс = Число(Сред(ДанныеСобытия.Anchor.href, Позиция + 1));
			ПоказатьРаздел(ТекущийДокумент,
			РазделыКонфигурации.Получить(Индекс).Название);

		Иначе;
			
			ПоказатьРаздел(ТекущийДокумент, ДанныеСобытия.Anchor.id);
			
		КонецЕсли;
	КонецЕсли;
	
#КонецЕсли

КонецПроцедуры

&НаКлиенте
Процедура ПолеHTMLДокументСформирован(Элемент)
	ВременнаяСсылка = Неопределено;
	ПоказатьРаздел(Элемент.Документ, РазделыКонфигурации[0].Название);
КонецПроцедуры
