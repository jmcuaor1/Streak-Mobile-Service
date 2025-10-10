class CompanyInfo {
  final String website;
  final String sector;
  final String headcount;
  final String hq;
  final String type;
  final String founded;
  final String specialty;

  // NUEVO
  final List<String> galleryUrls;

  const CompanyInfo({
    required this.website,
    required this.sector,
    required this.headcount,
    required this.hq,
    required this.type,
    required this.founded,
    required this.specialty,
    this.galleryUrls = const [], // por defecto vacío
  });
}
