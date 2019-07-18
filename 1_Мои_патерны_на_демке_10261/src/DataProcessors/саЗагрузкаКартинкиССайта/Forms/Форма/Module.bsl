
&НаКлиенте
Процедура Загрузить(Команда)
	
	//1. создаем HTTP-соединение
	HTTP = Новый HTTPСоединение("Курсы-по-1С.рф",,,,,,,Ложь);
		
	//2. создаем соответствие ЗаголовокЗапросаHTTP и заполняем заголовки
	ЗаголовокЗапросаHTTP = Новый Соответствие();
	ЗаголовокЗапросаHTTP.Вставить("Accept", "image/png");
	ЗаголовокЗапросаHTTP.Вставить("User-Agent", "1C+Enterprise/8.3");
	
	//TODO с работы 3
	//3. создаем HTTP-запрос
	HTTPЗапрос = Новый HTTPЗапрос(
		"/wp-content/uploads/2016/11/kursy-po-1c.ru-logo-300wide-58high-2016-11-02-v2.png", 
		ЗаголовокЗапросаHTTP);
		
	//4. отправляем HTTP-запрос
	Ответ = HTTP.Получить(HTTPЗапрос, "D:\logo.png");
		
	//5. обрабатывает ответ на запрос
	Если Ответ.КодСостояния = 200 Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Картинка получена";
		Сообщение.Сообщить(); 
	Иначе		
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Картинка не получена. Статус-код " + Ответ.КодСостояния;
		Сообщение.Сообщить(); 
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьБанки(Команда)
	
	//1. создаем HTTP-соединение
	HTTP = Новый HTTPСоединение("nbrb.by",,,,,,,Ложь);
	
	//2. создаем соответствие ЗаголовокЗапросаHTTP и заполняем заголовки
	//ЗаголовокЗапросаHTTP = Новый Соответствие();
	//ЗаголовокЗапросаHTTP.Вставить("Accept", "image/png");
	//ЗаголовокЗапросаHTTP.Вставить("User-Agent", "1C+Enterprise/8.3");
	
	//3. создаем HTTP-запрос
	HTTPЗапрос = Новый HTTPЗапрос("/API/BIC");
		
	//4. отправляем HTTP-запрос
	//Ответ = HTTP.Получить(HTTPЗапрос, "D:\банки.txt");
	Ответ = HTTP.Получить(HTTPЗапрос);
		
	//5. обрабатывает ответ на запрос
	Если Ответ.КодСостояния = 200 Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Банки получены";
		Сообщение.Сообщить(); 
		
		ТекстОтвета = Ответ.ПолучитьТелоКакСтроку();	
		
		МасивСтрок = СтрРазделить(ТекстОтвета, "}");
		МасивСтрок.Удалить(МасивСтрок.Количество()-1);
		
		Для каждого Строка Из МасивСтрок Цикл
		
			Строка = Сред( Строка, 3);
			
			Масив = СтрРазделить( Строка, ",");
			
			НоваяСтрока = СписокБанков.Добавить();
			
			МасивБанк = СтрРазделить( Масив[0], ":");
			НоваяСтрока.Банк = МасивБанк[1];
			
			//МасивБИК = СтрРазделить( Масив[1], ":");
			//НоваяСтрока.БИК = МасивБИК[1];
			//
			//МасивБИКГоловного = СтрРазделить( Масив[2], ":");
			//НоваяСтрока.БИКГоловного = МасивБИКГоловного[1];
			//
			//МасивУсловныйНомер = СтрРазделить( Масив[3], ":");
			//НоваяСтрока.УсловныйНомер = МасивУсловныйНомер[1];
			
			МасивБИК = СтрРазделить( Масив[1], ":");
			НоваяСтрока.БИК = Сред(МасивБИК[1], 2, СтрДлина(МасивБИК[1])-2 );
			
			МасивБИКГоловного = СтрРазделить( Масив[2], ":");
			НоваяСтрока.БИКГоловного = МасивБИКГоловного[1];
			
			МасивУсловныйНомер = СтрРазделить( Масив[3], ":");
			НоваяСтрока.УсловныйНомер = Сред( МасивУсловныйНомер[1], 2, 3);
			
			МасивСтатусБИК = СтрРазделить( Масив[4], ":");
			НоваяСтрока.СтатусБИК = МасивСтатусБИК[1];
			
			МасивНаименованиеБанка = СтрРазделить( Масив[5], ":");
			НоваяСтрока.НаименованиеБанка = МасивНаименованиеБанка[1];
			
		КонецЦикла; 
		
		СписокБанков.Сортировать("УсловныйНомер");
		
	Иначе		
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Банки не получены. Статус-код " + Ответ.КодСостояния;
		Сообщение.Сообщить(); 
	КонецЕсли;
	
КонецПроцедуры
