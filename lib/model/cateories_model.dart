import 'dart:convert';

List<CategoriesModel> categoriesModelFromJson(String str) => List<CategoriesModel>.from(json.decode(str).map((x) => CategoriesModel.fromJson(x)));

String categoriesModelToJson(List<CategoriesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoriesModel {
    CategoriesModel({
        this.id,
        this.name,
        this.slug,
        this.status,
        this.photo,
        this.isFeatured,
        this.image,
        this.subcategories,
        this.childcategories,
    });

    int id;
    String name;
    String slug;
    int status;
    String photo;
    int isFeatured;
    String image;
    List<Category> subcategories;
    List<Category> childcategories;

    factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        status: json["status"],
        photo: json["photo"] == null ? null : json["photo"],
        isFeatured: json["is_featured"],
        image: json["image"] == null ? null : json["image"],
        subcategories: json["subcategories"] == null ? null : List<Category>.from(json["subcategories"].map((x) => Category.fromJson(x))),
        childcategories: json["childcategories"] == null ? null : List<Category>.from(json["childcategories"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "status": status,
        "photo": photo == null ? null : photo,
        "is_featured": isFeatured,
        "image": image == null ? null : image,
        "subcategories": subcategories == null ? null : List<dynamic>.from(subcategories.map((x) => x.toJson())),
        "childcategories": childcategories == null ? null : List<dynamic>.from(childcategories.map((x) => x.toJson())),
    };
}

class Category {
    Category({
        this.id,
        this.subcategoryId,
        this.name,
        this.slug,
        this.status,
        this.categoryId,
    });

    int id;
    int subcategoryId;
    String name;
    String slug;
    int status;
    int categoryId;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        subcategoryId: json["subcategory_id"] == null ? null : json["subcategory_id"],
        name: json["name"],
        slug: json["slug"],
        status: json["status"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "subcategory_id": subcategoryId == null ? null : subcategoryId,
        "name": name,
        "slug": slug,
        "status": status,
        "category_id": categoryId == null ? null : categoryId,
    };
}
