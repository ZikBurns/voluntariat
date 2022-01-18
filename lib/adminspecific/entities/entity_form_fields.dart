import 'package:flutter/material.dart';
import 'package:flutter_firestore/utils/strings.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

class EntityFormFields extends StatelessWidget {

  Align titleText(String text){
    return Align(
      alignment: Alignment.topLeft,
      child: Text(text,
          style: TextStyle(fontSize: 20, color: Colors.black)),
    );
  }
  Align titledesc(String text){
    return Align(
      alignment: Alignment.topLeft,
      child: Text(text,
          style: TextStyle(fontSize: 14, color: Colors.black)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            titleText(Strings.formEntityNom),
            FormBuilderTextField(
              maxLines: 1,
              obscureText: false,
              name: 'name',
              readOnly: false,
              validator: FormBuilderValidators.compose([
                    (val){
                  if(val=="") return Strings.formEntityNomWarn;
                }
              ]),
            ),
            SizedBox(height: 20),
            titleText(Strings.formEntityDesc),
            FormBuilderTextField(
              maxLines: 10,
              obscureText: false,
              name: 'desc',
              readOnly: false,
              validator: FormBuilderValidators.compose([(val){
                if(val=="") return "L'entitat ha de tenir una descripció.";
              }]),
            ),
            SizedBox(height: 20),
            titleText(Strings.formEntityYT),
            FormBuilderTextField(
              decoration: InputDecoration(
                hintText: Strings.formEntitySocialHint
              ),
              maxLines: 2,
              obscureText: false,
              name: 'ytlink',
              readOnly: false,
            ),
            SizedBox(height: 20),
            titleText(Strings.formEntityTwitter),
            FormBuilderTextField(
              decoration: InputDecoration(
                  hintText: Strings.formEntitySocialHint
              ),
              maxLines: 2,
              obscureText: false,
              name: 'twitter',
              readOnly: false,
            ),
            SizedBox(height: 20),
            titleText(Strings.formEntityFacebook),
            FormBuilderTextField(
              decoration: InputDecoration(
                  hintText: Strings.formEntitySocialHint
              ),
              maxLines: 1,
              obscureText: false,
              name: 'facebook',
              readOnly: false,
            ),
            SizedBox(height: 20),
            titleText(Strings.formEntityInstagram),
            FormBuilderTextField(
              decoration: InputDecoration(
                  hintText: Strings.formEntitySocialHint
              ),
              maxLines: 1,
              obscureText: false,
              name: 'instagram',
              readOnly: false,
            ),
            SizedBox(height: 20),
            titleText(Strings.formEntityWeb),
            FormBuilderTextField(
              decoration: InputDecoration(
                  hintText: Strings.formEntitySocialHint
              ),
              maxLines: 1,
              obscureText: false,
              name: 'website',
              readOnly: false,
            ),
            SizedBox(height: 20),
            titleText(Strings.formEntityMaps),
            FormBuilderTextField(
              decoration: InputDecoration(
                  hintText: Strings.formEntitySocialHint
              ),
              maxLines: 1,
              obscureText: false,
              name: 'maps',
              readOnly: false,
            ),
            titleText("Contacte de l'entitat: mails i/o telèfons"),
            FormBuilderTextField(
              maxLines: 5,
              obscureText: false,
              name: 'contact',
              readOnly: false,
            ),
            titleText("Tasques de voluntariat"),
            FormBuilderTextField(
              maxLines: 5,
              obscureText: false,
              name: 'tasks',
              readOnly: false,
            ),
            FormBuilderColorPickerField(
              name: 'color',
              colorPickerType: ColorPickerType.materialPicker,
              decoration: InputDecoration(labelText: Strings.formEntityColorHint),
            ),
          ],
        ),
      ),
    );
  }
}
