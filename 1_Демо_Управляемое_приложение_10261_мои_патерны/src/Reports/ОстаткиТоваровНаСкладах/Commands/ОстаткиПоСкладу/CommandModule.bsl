
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ПараметрыФормы = Новый Структура("Отбор,КлючНазначенияИспользования,СформироватьПриОткрытии", Новый Структура("Склад", ПараметрКоманды), "ОстаткиПоСкладу", Истина);
	ОткрытьФорму("Отчет.ОстаткиТоваровНаСкладах.Форма", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно);
	
КонецПроцедуры
