#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	ОбменДаннымиСервер.ФормаУзлаПриСозданииНаСервере(ЭтаФорма, Отказ);
	
	Если Не ЗначениеЗаполнено(Объект.ПравилаОтправкиСправочников) Тогда
		Объект.ПравилаОтправкиСправочников = "АвтоматическаяСинхронизация";
	КонецЕсли;
	Если Не ЗначениеЗаполнено(Объект.ПравилаОтправкиЦен) Тогда
		Объект.ПравилаОтправкиЦен = "АвтоматическаяСинхронизация";
	КонецЕсли;
	Если Не ЗначениеЗаполнено(Объект.ПравилаОтправкиДокументов) Тогда
		Объект.ПравилаОтправкиДокументов = "АвтоматическаяСинхронизация";
	КонецЕсли;
	Если Не ЗначениеЗаполнено(Объект.РежимВыгрузкиПриНеобходимости) тогда
		Объект.РежимВыгрузкиПриНеобходимости = 
			Перечисления.РежимыВыгрузкиОбъектовОбмена.ВыгружатьПриНеобходимости;
	КонецЕсли;

	
	Если Объект.ИспользоватьОтборПоОрганизациям Тогда
		
		ПравилоОтбораСправочников = "Отбор";
		
	Иначе
		
		ПравилоОтбораСправочников = "БезОтбора";
		
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"УстановитьДатуЗапретаИзменений",
		"Доступность",
		ПравоДоступа("Изменение", Метаданные.РегистрыСведений.ДатыЗапретаИзменения));

	УстановитьВидимостьНаСервере();

	ОбновитьНаименованиеКомандФормы();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	Если Не ЗавершениеРаботы Тогда
		Оповестить("Запись_УзелПланаОбмена");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	ОбновитьИнтерфейс();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	ОбновитьДанныеОбъекта(ВыбранноеЗначение);
	Модифицированность = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	ОбменДаннымиКлиент.ФормаНастройкиПередЗакрытием(Отказ, ЭтотОбъект, ЗавершениеРаботы);
	
КонецПроцедуры

#КонецОбласти
#Область ОбработчикиСобытийЭлементовШапкиФормы
&НаКлиенте
Процедура ФлагИспользоватьОтборПоОрганизациямПриИзменении(Элемент)
	УстановитьВидимостьНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПереключательОтправлятьНСИАвтоматическиПриИзменении(Элемент)
	УстановитьВидимостьНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПереключательОтправлятьНСИПоНеобходимостиПриИзменении(Элемент)
	
	Если Объект.ПравилаОтправкиСправочников = "СинхронизироватьПоНеобходимости" 
		И Объект.ПравилаОтправкиДокументов = "НеСинхронизировать" Тогда
		
		Объект.ПравилаОтправкиДокументов = "АвтоматическаяСинхронизация";
		
	КонецЕсли;
	
	УстановитьВидимостьНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПереключательОтправлятьНСИНикогдаПриИзменении(Элемент)
	Объект.ПравилаОтправкиЦен        = "НеСинхронизировать";
	Объект.ПравилаОтправкиДокументов = "НеСинхронизировать";
	УстановитьВидимостьНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПереключательДокументыОтправлятьАвтоматическиПриИзменении(Элемент)
	Объект.ПравилаОтправкиЦен = Объект.ПравилаОтправкиДокументов;
	УстановитьВидимостьНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПереключательДокументыОтправлятьВручнуюПриИзменении(Элемент)
	Объект.ПравилаОтправкиЦен = Объект.ПравилаОтправкиДокументов;
	УстановитьВидимостьНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПереключательДокументыНеОтправлятьПриИзменении(Элемент)
	Объект.ПравилаОтправкиЦен = Объект.ПравилаОтправкиДокументов;
	УстановитьВидимостьНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура СкладыПослеУдаления(Элемент)
	
	Если Объект.Склады.Количество() = 0 Тогда
		ТипЦенДляИзмененияЦен = ПредопределенноеЗначение("Справочник.ТипыЦенНоменклатуры.ПустаяСсылка");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СкладыСкладНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ПараметрыФормы = Новый Структура();
	ПараметрыФормы.Вставить("РежимВыбора", Истина);
	ПараметрыФормы.Вставить("Отбор", Новый Структура("ТипСклада", ПредопределенноеЗначение("Перечисление.ТипыСкладов.РозничныйМагазин")));
	ПараметрыФормы.Вставить("КлючПользовательскихНастроек", "ВыборРозничногоСклада");
	ПараметрыФормы.Вставить("ОтборТипЦенРозничнойТорговли", Объект.ТипЦенДляИзмененияЦен);
	ТекущиеДанные = Элементы.Склады.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено
		И ЗначениеЗаполнено(ТекущиеДанные.Склад) Тогда
		ПараметрыФормы.Вставить("ТекущаяСтрока", ТекущиеДанные.Склад);
	КонецЕсли;
	
	ОткрытьФорму("Справочник.Склады.ФормаВыбора", ПараметрыФормы, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура СкладыСкладПриИзменении(Элемент)
	
	Строка = Объект.Склады.НайтиПоИдентификатору(Элементы.Склады.ТекущаяСтрока);
	Если Объект.Склады.Индекс(Строка) = 0 Тогда
		УстановитьВыбранныйТипЦенРозничнойТорговли();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОткрытьСписокВыбранныхОрганизаций(Команда)
	
	КоллекцияФильтров = Неопределено;
	
	ПараметрыФормы = Новый Структура();
	ПараметрыФормы.Вставить("ИмяЭлементаФормыДляЗаполнения",          "Организации");
	ПараметрыФормы.Вставить("ИмяРеквизитаЭлементаФормыДляЗаполнения", "Организация");
	ПараметрыФормы.Вставить("ИмяТаблицыВыбора",                       "Справочник.Организации");
	ПараметрыФормы.Вставить("ЗаголовокФормыВыбора",                   НСтр("ru = 'Выберите организации для отбора:'"));
	ПараметрыФормы.Вставить("МассивВыбранныхЗначений",                СформироватьМассивВыбранныхЗначений(ПараметрыФормы));
	ПараметрыФормы.Вставить("ПараметрыВнешнегоСоединения",            Неопределено);
	ПараметрыФормы.Вставить("КоллекцияФильтров",                      КоллекцияФильтров);
	
	ОткрытьФорму("ОбщаяФорма.ФормаВыбораДополнительныхУсловий",
		ПараметрыФормы,
		ЭтаФорма);
	
КонецПроцедуры
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Прочее

&НаКлиенте
Процедура ЗавершениеВыбораФайлаМенеджераОбмена(Знач РезультатПомещенияФайлов, Знач ДополнительныеПараметры) Экспорт
	
	ОчиститьСообщения();
	
	АдресПомещенногоФайла = РезультатПомещенияФайлов.Хранение;
	ТекстОшибки           = РезультатПомещенияФайлов.ОписаниеОшибки;
	
	Объект.ПутьКМенеджеруОбмена = РезультатПомещенияФайлов.Имя;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьДанныеОбъекта(СтруктураПараметров)
	
	Объект[СтруктураПараметров.ИмяТаблицыДляЗаполнения].Очистить();
	
	СписокВыбранныхЗначений = ПолучитьИзВременногоХранилища(СтруктураПараметров.АдресТаблицыВоВременномХранилище);
	
	Если СписокВыбранныхЗначений.Количество() > 0 Тогда
		СписокВыбранныхЗначений.Колонки.Представление.Имя = СтруктураПараметров.ИмяКолонкиДляЗаполнения;
		Объект[СтруктураПараметров.ИмяТаблицыДляЗаполнения].Загрузить(СписокВыбранныхЗначений);
	КонецЕсли;
	
	ОбновитьНаименованиеКомандФормы();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьНаСервере()
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ГруппаВыгрузкаКассаРозничныеСклады",
		"Видимость",
		Объект.ВариантНастройки = "ОбменКасса");
	
	Если Объект.ВариантНастройки = "ОбменКасса" Тогда
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"ГруппаОсновные",
			"Видимость",
			Ложь);
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"ГруппаНастройкаДополнительныхОтборов",
			"Видимость",
			Ложь);
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"ГруппаПрочее",
			"Видимость",
			Ложь);
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"ГруппаСтатьяПрочихДоходовРасходовПоУмолчанию",
			"Видимость",
			Ложь);
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"ГруппаСкладПоУмолчанию",
			"Видимость",
			Ложь);
		
	Иначе
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"ДатаНачалаВыгрузкиДокументов",
			"Доступность",
			Объект.ПравилаОтправкиДокументов = "АвтоматическаяСинхронизация");
			
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"ПереключательДокументыНеОтправлять",
			"Доступность",
			Не Объект.ПравилаОтправкиСправочников = "СинхронизироватьПоНеобходимости");
			
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"ОписаниеДокументыНеОтправлять",
			"Доступность",
			Не Объект.ПравилаОтправкиСправочников = "СинхронизироватьПоНеобходимости");
			
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы.ГруппаДокументы.ПодчиненныеЭлементы,
			"ГруппаРежимОтправкиДокументов",
			"Доступность",
			Не Объект.ПравилаОтправкиСправочников = "НеСинхронизировать");
			
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"ПравилаОтправкиДанных",
			"Видимость",
			Объект.ВариантНастройки <> "ОбменУТБП");
		
		#Область ГруппаНастройкаДополнительныхОтборов
		ВидимостьГруппы = ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоОрганизаций")
			И Объект.ПравилаОтправкиСправочников <> "НеСинхронизировать";
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"ГруппаНастройкаДополнительныхОтборов",
			"Видимость",
			ВидимостьГруппы);
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"ОткрытьСписокВыбранныхОрганизаций",
			"Доступность",
			Объект.ИспользоватьОтборПоОрганизациям);
		#КонецОбласти

		#Область ГруппаПрочее
		ВидимостьГруппы = Объект.ПравилаОтправкиДокументов <> "НеСинхронизировать"
			Или Объект.ПравилаОтправкиСправочников <> "НеСинхронизировать";
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"ГруппаПрочееГор",
			"Видимость",
			ВидимостьГруппы);
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"ВыгружатьАналитикуПоСкладам",
			"Видимость",
			Объект.ПравилаОтправкиДокументов <> "НеСинхронизировать");
		#КонецОбласти
	
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьНаименованиеКомандФормы()
	
	//Обновим заголовок выбранных организаций
	Если Объект.Организации.Количество() > 0 Тогда
		
		ВыбранныеОрганизации = Объект.Организации.Выгрузить().ВыгрузитьКолонку("Организация");
		НовыйЗаголовокОрганизаций = СтрСоединить(ВыбранныеОрганизации, ",");
		
	Иначе
		
		НовыйЗаголовокОрганизаций = НСтр("ru = 'Выбрать организации'");
		
	КонецЕсли;
	
	Элементы.ОткрытьСписокВыбранныхОрганизаций.Заголовок = НовыйЗаголовокОрганизаций;
	
	
КонецПроцедуры

&НаСервере
Функция СформироватьМассивВыбранныхЗначений(ПараметрыФормы)
	
	ТабличнаяЧасть           = Объект[ПараметрыФормы.ИмяЭлементаФормыДляЗаполнения];
	ТаблицаВыбранныхЗначений = ТабличнаяЧасть.Выгрузить(,ПараметрыФормы.ИмяРеквизитаЭлементаФормыДляЗаполнения);
	МассивВыбранныхЗначений  = ТаблицаВыбранныхЗначений.ВыгрузитьКолонку(ПараметрыФормы.ИмяРеквизитаЭлементаФормыДляЗаполнения);
	
	Возврат МассивВыбранныхЗначений;

КонецФункции

&НаСервереБезКонтекста
Функция ТипЦенСклада(Склад)
	
	Если ЗначениеЗаполнено(Склад) Тогда
		Возврат ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Склад, "ТипЦенРозничнойТорговли");
	Иначе
		Возврат Справочники.ТипыЦенНоменклатуры.ПустаяСсылка();
	КонецЕсли;
	
КонецФункции

&НаСервере
Функция УстановитьВыбранныйТипЦенРозничнойТорговли()
	
	Если Объект.Склады.Количество() > 0 Тогда
		Объект.ТипЦенДляИзмененияЦен = ТипЦенСклада(Объект.Склады[0].Склад);
	Иначе
		Объект.ТипЦенДляИзмененияЦен = Справочники.ТипыЦенНоменклатуры.ПустаяСсылка();
	КонецЕсли;
	
	МассивПараметров = Новый Массив;
	МассивПараметров.Добавить(Новый ПараметрВыбора("Отбор.ТипСклада", Перечисления.ТипыСкладов.РозничныйМагазин));
	
	Если ЗначениеЗаполнено(Объект.ТипЦенДляИзмененияЦен) Тогда
		МассивПараметров.Добавить(Новый ПараметрВыбора("Отбор.ТипЦенРозничнойТорговли", Объект.ТипЦенДляИзмененияЦен));
	КонецЕсли;
	
	Элементы.СкладыСклад.ПараметрыВыбора = Новый ФиксированныйМассив(МассивПараметров);
	
КонецФункции

#КонецОбласти

#КонецОбласти

