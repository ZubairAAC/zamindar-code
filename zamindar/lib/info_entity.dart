import 'package:zamindar/generated/json/base/json_convert_content.dart';
import 'package:zamindar/generated/json/base/json_field.dart';

class InfoEntity with JsonConvert<InfoEntity> {
	@JSONField(name: "_id")
	String sId;
	String title;
	String description;
	String image;
}
