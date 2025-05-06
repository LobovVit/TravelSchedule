//
//  MockData.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 14.04.2025.
//

struct Mock {
    
    static let carrierSampleData: [Carrier] = [
        Carrier(code: 1, title: "РЖД", logoUrl: "rzhd", logoSVGUrl: "rzhd", placeholder: "airplane", email: "qweasd@ya.ru", phone: "+7 (999) 999-99-99", contacts: "Контактная информация"),
        Carrier(code: 2, title: "ФГК", logoUrl: "fgk", logoSVGUrl: "fgk", placeholder: "cablecar", email: "qqqweasd@ya.ru", phone: "+7 (999) 999-99-99", contacts: "Контактная информация"),
        Carrier(code: 3, title: "Урал логистика", logoUrl: "ural", logoSVGUrl: "ural", placeholder: "ferry", email: "wwwqweasd@ya.ru", phone: "+7 (999) 999-99-9", contacts: "Контактная информация")
    ]
    
    static let citySampleData = [
        City(title: "Москва", yandexCode: "", stationsCount: 0),
        City(title: "Санкт-Петербург", yandexCode: "", stationsCount: 0),
        City(title: "Сочи", yandexCode: "", stationsCount: 0),
        City(title: "Горный Воздух", yandexCode: "", stationsCount: 0),
        City(title: "Краснодар", yandexCode: "", stationsCount: 0),
        City(title: "Казань", yandexCode: "", stationsCount: 0),
        City(title: "Омск", yandexCode: "", stationsCount: 0)
    ]

    static let destinationSampleData: [Destination] = [
        Destination(city: citySampleData[0], station: stationSampleData[0]),
        Destination(city: citySampleData[1], station: stationSampleData[1])
    ]
    
    static let routeSampleData: [Route] = [
        Route(
            code: "1_6_2",
            date: "14 марта",
            departureTime: "23:33",
            arrivalTime: "08:33",
            durationTime: "20",
            connectionStation: "",
            carrierCode: carrierSampleData[0].code
        ),
        Route(
            code: "1_6_2",
            date: "15 марта",
            departureTime: "01:15",
            arrivalTime: "19:00",
            durationTime: "9",
            connectionStation: "Кострома",
            carrierCode: carrierSampleData[1].code
        ),
        Route(
            code: "1_6_2",
            date: "16 марта",
            departureTime: "12:30",
            arrivalTime: "21:00",
            durationTime: "9",
            connectionStation: "",
            carrierCode: carrierSampleData[2].code
        )
    ]
    
    static let stationSampleData = [
        Station(title: "Киевский вокзал", type: "dummy", code: "dummy", latitude: 0, longitude: 0),
        Station(title: "Курский вокзал", type: "dummy", code: "dummy", latitude: 0, longitude: 0),
        Station(title: "Ярославский вокзал", type: "dummy", code: "dummy", latitude: 0, longitude: 0),
        Station(title: "Белорусский вокзал", type: "dummy", code: "dummy", latitude: 0, longitude: 0),
        Station(title: "Савеловский вокзал", type: "dummy", code: "dummy", latitude: 0, longitude: 0),
        Station(title: "Ленинградский вокзал", type: "dummy", code: "dummy", latitude: 0, longitude: 0)
    ]
    
    static let schedulesSampleData = Schedules(
        cities: citySampleData,
        stations: stationSampleData,
        destinations: Destination.emptyDestination,
        routes: routeSampleData,
        carriers: carrierSampleData
    )
    
    static let title = Array(repeating: "title", count: 5).joined(separator: " ").capitalized
    static let description = Array(repeating: "text", count: 5).joined(separator: " ")
    
    static let storiesSampleData: [Story] = [
        Story(imageName: "pic1", title: title, description: description),
        Story(imageName: "pic2", title: title, description: description),
        Story(imageName: "pic3", title: title, description: description),
        Story(imageName: "pic4", title: title, description: description),
        Story(imageName: "pic5", title: title, description: description),
        Story(imageName: "pic6", title: title, description: description),
        Story(imageName: "pic7", title: title, description: description),
        Story(imageName: "pic8", title: title, description: description),
        Story(imageName: "pic9", title: title, description: description),
        Story(imageName: "pic10", title: title, description: description),
        Story(imageName: "pic11", title: title, description: description),
        Story(imageName: "pic12", title: title, description: description),
        Story(imageName: "pic13", title: title, description: description),
        Story(imageName: "pic14", title: title, description: description)
    ]
}
