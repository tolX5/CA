Процедура ПолучитьВерсииФорматаОбмена(ВерсииФормата) Экспорт
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	| СинхронизацияДанныхЧерезУниверсальныйФормат.ПутьКМенеджеруОбмена
	|ИЗ
	| ПланОбмена.СинхронизацияДанныхЧерезУниверсальныйФормат КАК СинхронизацияДанныхЧерезУниверсальныйФормат
	|ГДЕ
	| СинхронизацияДанныхЧерезУниверсальныйФормат.ПутьКМенеджеруОбмена <> """"");
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		ВерсииФормата.Вставить("1.3", ВнешниеОбработки.Создать(Выборка.ПутьКМенеджеруОбмена));
	Иначе
		ВерсииФормата.Вставить("1.3", МенеджерОбменаЧерезУниверсальныйФормат);
	КонецЕсли;
	
КонецПроцедуры

