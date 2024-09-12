import 'package:flutter/material.dart';
import 'package:gestao_notas/app/aplicacao/ap_professor.dart';
import 'package:gestao_notas/app/dominio/dto/dto_professor.dart';

class ProfessorLista extends StatelessWidget {

  const ProfessorLista({super.key});

  CircleAvatar circleAvatar(String? url)  {
    var avatar = const CircleAvatar(child: Icon(Icons.person));
    if(url != null){
      var uri = Uri.tryParse(url);
      if(uri != null && uri.isAbsolute){
        avatar = CircleAvatar(backgroundImage: NetworkImage(url));
      }
    }
    return avatar;
  }

  Widget iconEditButton(VoidCallback onPressed){
    return IconButton(icon: const Icon(Icons.edit), color: Colors.orange, onPressed: onPressed);
  }

  Widget iconRemoveButton(BuildContext context, VoidCallback remove){
    return IconButton(
      icon: const Icon(Icons.delete), 
      color: Colors.red, 
      onPressed: () {
        showDialog(
          context: context, 
          builder:  (context) => AlertDialog(
            title: const Text('Excluir'),
            content: const Text('Confirma a Exclusão?'),
            actions: [
              TextButton(
                child: const Text('Não'), 
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                onPressed: remove,
                child: const Text('Sim'),
              ),
            ],
          )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    var apProfessor = APProfessor();
    var lista = apProfessor.consultar();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Professores'),
          actions: [
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  //_back.goToForm(context);
                })
          ],
        ),
        body: FutureBuilder(
          future: lista,
          builder: (BuildContext context, AsyncSnapshot<List<DTOProfessor>>  futuro) {
            if (!futuro.hasData || futuro.data == null) {
              return const CircularProgressIndicator();
            } else {
              List<DTOProfessor> lista = futuro.data!;
              return ListView.builder(
                itemCount: lista.length,
                itemBuilder: (context, i) {
                  var professor = lista[i];
                  return ListTile(
                    leading: circleAvatar(professor.urlAvatar),
                    title: Text(professor.nome),
                    onTap: (){
                      //_back.goToDetails(context, contato);
                    },
                    subtitle: Text(professor.descricao??''),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          iconEditButton((){
                            // _back.goToForm(context, contato);
                          }),
                          iconRemoveButton(context, (){
                            // _back.remove(contato.id, context);
                          })
                        ],
                      ),
                    ),
                  );
                },
              );
            }
        }));
  }
}