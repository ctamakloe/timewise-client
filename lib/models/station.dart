class Station {
  String code;
  String name;

  Station({this.code, this.name});

  static List<Station> getStations() {
    List<Station> list = [];
    stations.forEach((key, value) {
      list.add(Station(code: key, name: value));
    });
    return list;
  }

  static final stations = {
    'NOT': 'Nottingham',
    'MIA': 'Manchester Airport',
    'MCO': 'Manchester Oxford Road',
    'MAN': 'Manchester Piccadilly',
    'MUF': 'Manchester United Football Ground',
    'MCV': 'Manchester Victoria',
    'QPW': 'Queens Park (London)',
    'RMD': 'Richmond (London)',
    'SAJ': 'St Johns (London)',
    'SMG': 'St Margarets (London)',
    'SRA': 'Stratford (London)',
    'STE': 'Streatham (Greater London)',
    'SYD': 'Sydenham (London)',
    'WTN': 'Whitton (London)',
    'LEE': 'Lee (London)',
    'BFR': 'London Blackfriars',
    'LBG': 'London Bridge',
    'CST': 'London Cannon Street',
    'CHX': 'London Charing Cross',
    'EUS': 'London Euston',
    'FST': 'London Fenchurch Street',
    'LOF': 'London Fields',
    'KGX': 'London Kings Cross',
    'LST': 'London Liverpool Street',
    'MYB': 'London Marylebone',
    'PAD': 'London Paddington',
    'LRB': 'London Road (Brighton)',
    'LRD': 'London Road (Guildford)',
    'SPX': 'London St Pancras (Intl)',
    'STP': 'London St Pancras International',
    'VIC': 'London Victoria',
    'WAT': 'London Waterloo',
    'WAE': 'London Waterloo East',
    'KET': 'Kettering',
    'WEL': 'Wellingborough',
    'LBO': 'Loughborough',
    'LGJ': 'Loughborough Junction',
    'MHR': 'Market Harborough',
    'BEE': 'Beeston',
    'ATB': 'Attenborough',
    'LGE': 'Long Eaton',
    'BDM': 'Bedford',
    'LUT': 'Luton',
    'LTN': 'Luton Airport Parkway',
    'LEI': 'Leicester',
  };
}


