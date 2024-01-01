class City {
  final String name;

  City(this.name);

  @override
  String toString() {
    return name;
  }
  static List<City> sortByName(List<City> cities) {
    cities.sort((a, b) => a.name.compareTo(b.name));
    return cities;
  }
}

List<City> getCities() {
  List<String> cityData = [
    'Manama',
    'Riffa',
    'Muharraq',
    'Hamad Town',
    'Isa Town',
    'Sitra',
    'Budaiya',
    'Jidhafs',
    'Al-Malikiyah',
    'A\'ali',
    'Abu Saiba',
    'Al Hajar',
    'Al Lawzi',
    'Al Markh',
    'Al Qadam',
    'Al Qala',
    'Al Safiria',
    'Barbar',
    'Boori',
    'Buquwa',
    'Dar Kulaib',
    'Diraz',
    'Dumistan',
    'Hamala',
    'Hillat Abdul Saleh',
    'Jablat Habshi',
    'Janabiya',
    'Jannusan',
    'Jasra',
    'Jid Al-Haj',
    'Jidda Island',
    'Karrana',
    'Karzakan',
    'Malikiya',
    'Sanabis',
    'Muqaba',
    'North Sehla',
    'Northern City',
    'Nurana Islands',
    'Qurayya',
    'Saar',
    'Sadad',
    'Salmabad',
    'Shahrakan',
    'Shakhura',
    'Umm an Nasan',
    'Umm as Sabaan',
    'Zayed City',
    // ... other cities
  ];

 
  List<City> cities = [];

  for (String cityName in cityData) {
    cities.add(City(cityName));
  }

  return cities;
}