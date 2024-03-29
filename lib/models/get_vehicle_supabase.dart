import 'dart:convert';

GetVehicleSupabase getVehicleSupabaseFromMap(String str) => GetVehicleSupabase.fromMap(json.decode(str));

String getVehicleSupabaseToMap(GetVehicleSupabase data) => json.encode(data.toMap());

class GetVehicleSupabase {
    GetVehicleSupabase({
        required this.vehicleCollection,
    });

    final VehicleCollection vehicleCollection;

    factory GetVehicleSupabase.fromMap(Map<String, dynamic> json) => GetVehicleSupabase(
        vehicleCollection: VehicleCollection.fromMap(json["vehicleCollection"]),
    );

    Map<String, dynamic> toMap() => {
        "vehicleCollection": vehicleCollection.toMap(),
    };
}

class VehicleCollection {
    VehicleCollection({
        required this.edges,
    });

    final List<Edge> edges;

    factory VehicleCollection.fromMap(Map<String, dynamic> json) => VehicleCollection(
        edges: List<Edge>.from(json["edges"].map((x) => Edge.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "edges": List<dynamic>.from(edges.map((x) => x.toMap())),
    };
}

class Edge {
    Edge({
        required this.node,
    });

    final Node node;

    factory Edge.fromMap(Map<String, dynamic> json) => Edge(
        node: Node.fromMap(json["node"]),
    );

    Map<String, dynamic> toMap() => {
        "node": node.toMap(),
    };
}

class Node {
    Node({
        required this.id,
        required this.make,
        required this.model,
        required this.year,
        required this.vin,
        required this.licensePlates,
        required this.motor,
        required this.color,
        required this.image,
        required this.idStatusFk,
        required this.idCompanyFk,
        required this.oilChangeDue,
        required this.registrationDue,
        required this.insuranceRenewalDue,
        required this.dateAdded,
        required this.ruleOilChange,
        required this.ruleTransmissionFluidChange,
        required this.ruleRadiatorFluidChange,
    });

    final String id;
    final String make;
    final String model;
    final String year;
    final String vin;
    final String licensePlates;
    final String motor;
    final String color;
    final String image;
    final String idStatusFk;
    final String idCompanyFk;
    final DateTime oilChangeDue;
    final DateTime registrationDue;
    final DateTime insuranceRenewalDue;
    final DateTime dateAdded;
    final RuleChange ruleOilChange;
    final RuleChange ruleTransmissionFluidChange;
    final RuleChange ruleRadiatorFluidChange;

    factory Node.fromMap(Map<String, dynamic> json) => Node(
        id: json["id_vehicle"],
        make: json["make"],
        model: json["model"],
        year: json["year"],
        vin: json["vin"],
        licensePlates: json["license_plates"],
        motor: json["motor"],
        color: json["color"],
        image: json["image"],
        idStatusFk: json["id_status_fk"],
        idCompanyFk: json["id_company_fk"],
        oilChangeDue: DateTime.parse(json["oil_change_due"]),
        registrationDue: DateTime.parse(json["registration_due"]),
        insuranceRenewalDue: DateTime.parse(json["insurance_renewal_due"]),
        dateAdded: DateTime.parse(json["date_added"]),
        ruleOilChange: RuleChange.fromMap(json["rule_oil_change"]),
        ruleTransmissionFluidChange: RuleChange.fromMap(json["rule_transmission_fluid_change"]),
        ruleRadiatorFluidChange: RuleChange.fromMap(json["rule_radiator_fluid_change"]),
    );

    Map<String, dynamic> toMap() => {
        "id_vehicle": id,
        "make": make,
        "model": model,
        "year": year,
        "vin": vin,
        "license_plates": licensePlates,
        "motor": motor,
        "color": color,
        "image": image,
        "id_status_fk": idStatusFk,
        "id_company_fk": idCompanyFk,
        "oil_change_due": oilChangeDue.toIso8601String(),
        "registration_due": registrationDue.toIso8601String(),
        "insurance_renewal_due": insuranceRenewalDue.toIso8601String(),
        "date_added": dateAdded.toIso8601String(),
        "rule_oil_change": ruleOilChange.toMap(),
        "rule_transmission_fluid_change": ruleTransmissionFluidChange.toMap(),
        "rule_radiator_fluid_change": ruleRadiatorFluidChange.toMap(),
    };
  
}

class RuleChange {
    final String value;
    final String registered;
    final int lastMileageService;

    RuleChange({
        required this.value,
        required this.registered,
        required this.lastMileageService,
    });

    factory RuleChange.fromJson(String str) => RuleChange.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RuleChange.fromMap(Map<String, dynamic> json) => RuleChange(
        value: json["Value"],
        registered: json["Registered"],
        lastMileageService: int.parse(json["Last Mileage Service"]),
    );

    Map<String, dynamic> toMap() => {
        "Value": value,
        "Registered": registered,
        "Last Mileage Service": lastMileageService.toInt(),
    };
}
