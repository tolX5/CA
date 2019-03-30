//////////////////////////////////////////////////////////////////////////////// 
// ОБРАБОТЧИКИ СОБЫТИЙ 
//

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	// TODO: поставил дома
	Если ПолучитьФункциональнуюОпцию("УчетПоСкладам") Тогда

		// Установка параметра Склад динамического списка.
		Если Параметры.Свойство("ОстаткиПоСкладу") Тогда

			СправочникСписок.Параметры.УстановитьЗначениеПараметра("ПоВсемСкладам", Ложь);
			СправочникСписок.Параметры.УстановитьЗначениеПараметра("Склад", Параметры.ОстаткиПоСкладу); 

		Иначе

			Отказ = Истина; 

		КонецЕсли

	Иначе

		СправочникСписок.Параметры.УстановитьЗначениеПараметра("ПоВсемСкладам", Истина);
		СправочникСписок.Параметры.УстановитьЗначениеПараметра("Склад", Справочники.Склады.ПустаяСсылка()); 

	КонецЕсли

КонецПроцедуры
