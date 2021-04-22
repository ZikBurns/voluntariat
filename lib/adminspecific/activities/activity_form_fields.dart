import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/utils/commonfunctions.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_firestore/utils/strings.dart';

class ActivityFormFields extends StatelessWidget {
  Activity activity;
  ActivityFormFields({this.activity});


  List<Entity> entitylist;

  FormBuilderCheckboxGroup builderCheckbox(){

    final List<String> namelist = CommonFunctions.entitiesToNames(entitylist);
    namelist.sort();
    if(this.activity!=null){
      List<String> initialcheckedentities=CommonFunctions.iDsToNames(this.activity.entities,entitylist);
      return FormBuilderCheckboxGroup(
        initialValue: initialcheckedentities,
        name: 'entities',
        options:
        namelist.map((e) => FormBuilderFieldOption(value: e)).toList(),
        validator: FormBuilderValidators.compose([
              (val){
            if((val==null)|| (val.length==0)) return Strings.formActivityWarnUnaEntitat;
          }
        ]),
        valueTransformer: (val)=> val==null ? val :List<dynamic>.from(CommonFunctions.namestoIDs(List<String>.from(val),entitylist)),
      );
    }
    else{
      return FormBuilderCheckboxGroup(
        name: 'entities',
        options:
        namelist.map((e) => FormBuilderFieldOption(value: e)).toList(),
        validator: FormBuilderValidators.compose([
              (val){
            if((val==null)|| (val.length==0)) return Strings.formActivityWarnUnaEntitat;
          }
        ]),
        valueTransformer: (val)=> val==null ? val : List<dynamic>.from(CommonFunctions.namestoIDs(List<String>.from(val),entitylist)),
      );
    }
  }

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
    entitylist= Provider.of<List<Entity>>(context) ?? [];
    FormBuilderCheckboxGroup entitycheckbox=builderCheckbox();

    return entitylist.length==0 ? CircularProgressIndicator(): Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            titleText(Strings.formActivityTextTitol),
            FormBuilderTextField(
              maxLines: 1,
              obscureText: false,
              name: 'title',
              readOnly: false,
              validator: FormBuilderValidators.compose([
                    (val){
                  if(val=="") return Strings.formActivityTextTitolWarn;
                }
              ]),
            ),
            SizedBox(height: 20),
            titleText(Strings.activityDesc),
            FormBuilderTextField(
              maxLines: 10,
              obscureText: false,
              name: 'desc',
              readOnly: false,
              validator: FormBuilderValidators.compose([(val){
                if(val=="") return Strings.formActivityTextDescWarn;
              }]),
            ),
            SizedBox(height: 20),
            titleText(Strings.formActivityTextEntitats),
            entitycheckbox,
            SizedBox(height: 20),
            titleText(Strings.formActivityTextTipologia),
            FormBuilderDropdown(
              hint: Text(Strings.formActivityTextSelType),
              name: 'type',
              items: [Strings.typesss,Strings.typeFamilia,Strings.typeEducacio,Strings.typeEsport,Strings.typeInter,Strings.typeBasic,Strings.typeMedi,Strings.typeJove,Strings.typeGran,Strings.typeAnimal,Strings.typeCult]
                  .map((type) =>
                  DropdownMenuItem(value: type, child: Text("$type")))
                  .toList(),
              validator: FormBuilderValidators.compose([
                    (val){
                  if((val==null)|| (val=="")) return Strings.formActivityWarnTipus;
                }
              ]),
            ),
            FormBuilderDropdown(
              hint: Text(Strings.formActivitySelectType),
              name: 'mode',
              items: [Strings.modePresencial,Strings.modeVirtual,Strings.modeSemi]
                  .map((type) =>
                  DropdownMenuItem(value: type, child: Text("$type")))
                  .toList(),
              validator: FormBuilderValidators.compose([
                    (val){
                  if((val==null)|| (val=="")) return Strings.formActivityWarnMode;
                }
              ]),
            ),
            SizedBox(height: 20),
            titleText(Strings.activityDates),
            titledesc(Strings.formActivityTextDatesExplicacio),
            FormBuilderDateTimePicker(
              name: 'startdate',
              format: DateFormat('dd-MM-yyyy'),
              inputType: InputType.date,
              decoration: InputDecoration(
                labelText: Strings.activityDataInici,
              ),
              validator: FormBuilderValidators.compose([
                    (val){
                  if((val==null)|| (val=="")) return "L'activitat ha de tenir una data d\'inici";
                }
              ]),
            ),
            FormBuilderDateTimePicker(
              name: 'finaldate',
              format: DateFormat('dd-MM-yyyy'),
              inputType: InputType.date,
              decoration: InputDecoration(
                labelText: Strings.activityDataFinal,
              ),
              validator: FormBuilderValidators.compose([
                    (val){
                  if((val==null)|| (val=="")) return "L'activitat ha de tenir una data final";
                }
              ]),
            ),
            FormBuilderDateTimePicker(
              name: 'visibledate',
              format: DateFormat('dd-MM-yyyy'),
              inputType: InputType.date,
              decoration: InputDecoration(
                labelText: Strings.formActivityTextDataVisible,
              ),
              validator: FormBuilderValidators.compose([
                    (val){
                  if((val==null)|| (val=="")) return Strings.formActivityTextDataVisibleWarn;
                }
              ]),
            ),
            FormBuilderDateTimePicker(
              name: 'launchdate',
              format: DateFormat('dd-MM-yyyy'),
              inputType: InputType.date,
              decoration: InputDecoration(
                labelText: Strings.formActivityTextDataLaunch,
              ),
              validator: FormBuilderValidators.compose([
                    (val){
                  if((val==null)|| (val=="")) return Strings.formActivityTextDataLaunchWarn;
                }
              ]),
            ),
            SizedBox(height: 20),
            titledesc(Strings.formActivityTextDiesLaunch),
            FormBuilderTouchSpin(
              name: 'releasedays',
              step: 1,
              textStyle: TextStyle(fontSize: 20, color: Colors.black),
            ),
            SizedBox(height: 20),
            titleText(Strings.activityLloc),
            FormBuilderTextField(
              maxLines: 1,
              obscureText: false,
              name: 'place',
              readOnly: false,
              validator: FormBuilderValidators.compose([
                    (val){
                  if(val=="") return Strings.formActivityTextLlocWarn;
                }
              ]),
            ),
            titleText(Strings.activityHorari),
            FormBuilderTextField(
              maxLines: 1,
              obscureText: false,
              name: 'schedule',
              readOnly: false,
              validator: FormBuilderValidators.compose([
                    (val){
                  if(val=="") return Strings.formActivityTextHorariWarn;
                }
              ]),
            ),
            SizedBox(height: 20),
            titleText(Strings.activityContacte),
            FormBuilderTextField(
              maxLines: 5,
              obscureText: false,
              name: 'contact',
              readOnly: false,
              validator: FormBuilderValidators.compose([
                    (val){
                  if(val=="") return Strings.formActivityTextContacteWarn;
                }
              ]),
            ),
            SizedBox(height: 20),
            titleText(Strings.formActivityTextVisibilitat),
            FormBuilderCheckbox(
              name: 'visible',
              title: Text(Strings.formActivityTextVisibilitatWarn),
            ),
            titleText(Strings.activityDestacat),
            FormBuilderCheckbox(
              name: 'prime',
              title: Text(Strings.formActivityTextDestacatWarn),
            ),
          ],
        ),
      ),
    );
  }
}
