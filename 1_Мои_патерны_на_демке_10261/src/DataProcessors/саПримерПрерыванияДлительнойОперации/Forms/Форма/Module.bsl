
&НаСервере
Процедура ЗапуститьНаСервере()
	
	// Ctrl-Break не остановить --> т.к. на сервере остановить невозможно!
	ВремяНачала = ТекущаяДата();
	Пока ТекущаяДата() - ВремяНачала <= 5 Цикл
	
	КонецЦикла; 
	
КонецПроцедуры

&НаКлиенте
Процедура Запустить(Команда)
	
	//ЗапуститьНаСервере(); //пример 5-и минутного цикла на Сервере
	
	ВремяНачала = ТекущаяДата();
	Пока ТекущаяДата() - ВремяНачала <= 5 Цикл
		ОбработкаПрерыванияПользователя(); // без этого и на клиенте не остановить
	КонецЦикла; 
	
КонецПроцедуры
