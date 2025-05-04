//
//  MockData.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 14.04.2025.
//

struct Mock {
    
    static let carrierSampleData: [Carrier] = [
        Carrier(title: "РЖД", logoName: "rzhd", email: "qweasd@ya.ru", phone: "+7 (999) 999-99-99"),
        Carrier(title: "ФГК", logoName: "fgk", email: "qqqweasd@ya.ru", phone: "+7 (999) 999-99-99"),
        Carrier(title: "Урал логистика", logoName: "ural", email: "wwwqweasd@ya.ru", phone: "+7 (999) 999-99-9")
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
        Destination(cityTitle: "Москва", stationTitle: "Ярославский Вокзал"),
        Destination(cityTitle: "Санкт-Петербург", stationTitle: "Балтийский вокзал")
    ]
    
    static let routeSampleData: [Route] = [
        Route(
            date: "14 марта",
            departureTime: "23:33",
            arrivalTime: "08:33",
            durationTime: "20",
            connectionStation: "",
            carrierID: carrierSampleData[0].id
        ),
        Route(
            date: "15 марта",
            departureTime: "01:15",
            arrivalTime: "19:00",
            durationTime: "9",
            connectionStation: "Кострома",
            carrierID: carrierSampleData[1].id
        ),
        Route(
            date: "16 марта",
            departureTime: "12:30",
            arrivalTime: "21:00",
            durationTime: "9",
            connectionStation: "",
            carrierID: carrierSampleData[2].id
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
