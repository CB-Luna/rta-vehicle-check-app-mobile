import 'dart:convert';

class GetUsuarioSupabase {
    final String id;
    final String email;
    final DateTime dateAdded;
    final String idPerfilUsuario;
    final int idSecuencial;
    final String name;
    final String? middleName;
    final String lastName;
    final DateTime? birthdate;
    final String address;
    final String? telephoneNumber;
    final String? homephoneNumber;
    final String? image;
    final List<Roles> roles;
    final Companys company;
    final Configuracion configuracion;
    final int idTema;
    final int? idVehicleFk;

    GetUsuarioSupabase({
        required this.id,
        required this.email,
        required this.dateAdded,
        required this.idPerfilUsuario,
        required this.idSecuencial,
        required this.name,
        this.middleName,
        required this.lastName,
        this.birthdate,
        required this.address,
        this.telephoneNumber,
        this.homephoneNumber,
        this.image,
        required this.roles,
        required this.company,
        required this.configuracion,
        required this.idTema,
        this.idVehicleFk,
    });

    factory GetUsuarioSupabase.fromJson(String str) => GetUsuarioSupabase.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetUsuarioSupabase.fromMap(Map<String, dynamic> json) => GetUsuarioSupabase(
        id: json["id"],
        email: json["email"],
        dateAdded: DateTime.parse(json["created_at"]),
        idPerfilUsuario: json["user_profile_id"],
        idSecuencial: json["sequential_id"],
        name: json["name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        birthdate: json["birthdate"] == null ? null : DateTime.parse(json["birthdate"]),
        address: json["address"],
        telephoneNumber: json["mobile_phone"],
        homephoneNumber: json["home_phone"],
        image: json["image"],
        roles: List<Roles>.from(json["roles"].map((x) => Roles.fromMap(x))),
        company: Companys.fromMap(json["company"]),
        configuracion: Configuracion.fromMap(json["configuracion"]),
        idTema: json["id_tema"],
        idVehicleFk: json["id_vehicle_fk"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "created_at": dateAdded.toIso8601String(),
        "user_profile_id": idPerfilUsuario,
        "sequential_id": idSecuencial,
        "name": name,
        "middle_name": middleName,
        "last_name": lastName,
        "birthdate": birthdate == null ? null : "${birthdate?.year.toString().padLeft(4, '0')}-${birthdate?.month.toString().padLeft(2, '0')}-${birthdate?.day.toString().padLeft(2, '0')}",
        "address": address,
        "mobile_phone": telephoneNumber,
        "home_phone": homephoneNumber,
        "image": image,
        "roles": List<dynamic>.from(roles.map((x) => x.toMap())),
        "company": company.toMap(),
        "configuracion": configuracion.toMap(),
        "id_tema": idTema,
        "id_vehicle_fk": idVehicleFk,
    };
}

class Companys {
    final int companyId;
    final String company;

    Companys({
        required this.companyId,
        required this.company,
    });

    factory Companys.fromJson(String str) => Companys.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Companys.fromMap(Map<String, dynamic> json) => Companys(
        companyId: json["id_company"],
        company: json["company"],
    );

    Map<String, dynamic> toMap() => {
        "id_company": companyId,
        "company": company,
    };
}

class Configuracion {
    final Dark dark;
    final Dark light;
    final Logos logos;

    Configuracion({
        required this.dark,
        required this.light,
        required this.logos,
    });

    factory Configuracion.fromJson(String str) => Configuracion.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Configuracion.fromMap(Map<String, dynamic> json) => Configuracion(
        dark: Dark.fromMap(json["dark"]),
        light: Dark.fromMap(json["light"]),
        logos: Logos.fromMap(json["logos"]),
    );

    Map<String, dynamic> toMap() => {
        "dark": dark.toMap(),
        "light": light.toMap(),
        "logos": logos.toMap(),
    };
}

class Dark {
    final String primaryText;
    final String primaryColor;
    final String tertiaryColor;
    final String secondaryColor;
    final String primaryBackground;

    Dark({
        required this.primaryText,
        required this.primaryColor,
        required this.tertiaryColor,
        required this.secondaryColor,
        required this.primaryBackground,
    });

    factory Dark.fromJson(String str) => Dark.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Dark.fromMap(Map<String, dynamic> json) => Dark(
        primaryText: json["primaryText"],
        primaryColor: json["primaryColor"],
        tertiaryColor: json["tertiaryColor"],
        secondaryColor: json["secondaryColor"],
        primaryBackground: json["primaryBackground"],
    );

    Map<String, dynamic> toMap() => {
        "primaryText": primaryText,
        "primaryColor": primaryColor,
        "tertiaryColor": tertiaryColor,
        "secondaryColor": secondaryColor,
        "primaryBackground": primaryBackground,
    };
}

class Logos {
    final String logoColor;
    final String logoBlanco;
    final String backgroundImage;
    final String animationBackground;

    Logos({
        required this.logoColor,
        required this.logoBlanco,
        required this.backgroundImage,
        required this.animationBackground,
    });

    factory Logos.fromJson(String str) => Logos.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Logos.fromMap(Map<String, dynamic> json) => Logos(
        logoColor: json["logoColor"],
        logoBlanco: json["LogoBlanco"],
        backgroundImage: json["backgroundImage"],
        animationBackground: json["animationBackground"],
    );

    Map<String, dynamic> toMap() => {
        "logoColor": logoColor,
        "LogoBlanco": logoBlanco,
        "backgroundImage": backgroundImage,
        "animationBackground": animationBackground,
    };
}

class Roles {
    final int id;
    final String name;
    final Permissions permissions;
    final String application;

    Roles({
        required this.id,
        required this.name,
        required this.permissions,
        required this.application,
    });

    factory Roles.fromJson(String str) => Roles.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Roles.fromMap(Map<String, dynamic> json) => Roles(
        id: json["role_id"],
        name: json["name"],
        permissions: Permissions.fromMap(json["permissions"]),
        application: json["application"],
    );

    Map<String, dynamic> toMap() => {
        "role_id": id,
        "name": name,
        "permissions": permissions.toMap(),
        "application": application,
    };
}

class Permissions {
    String? home;
    String? employees;
    String? userProfile;
    String? usersAdministration;

    Permissions({
      this.home,
      this.employees,
      this.userProfile,
      this.usersAdministration,
    });

    factory Permissions.fromJson(String str) => Permissions.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Permissions.fromMap(Map<String, dynamic> json) => Permissions(
        home: json["Home"],
        employees: json["Employees"],
        userProfile: json["User Profile"],
        usersAdministration: json["Users Administration"],
    );

    Map<String, dynamic> toMap() => {
        "Home": home,
        "Employees": employees,
        "User Profile": userProfile,
        "Users Administration": usersAdministration,
    };
}
