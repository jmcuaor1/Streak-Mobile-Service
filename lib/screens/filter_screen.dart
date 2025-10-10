import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _AdvancedFilterScreenState();
}

class _AdvancedFilterScreenState extends State<FilterScreen> {
  // Última actualización
  String _recency = 'Cualquier momento';

  // Tipo de puesto
  final Set<String> _jobTypes = {'Tiempo completo'};

  // Nivel
  final Set<String> _levels = {'Junior'};

  // Ciudad
  final List<String> _cities = ['California, USA','Texas, USA','New York, USA','Florida, USA'];
  final Set<String> _selectedCities = {'California, USA'};

  // Salario (k)
  RangeValues _salary = const RangeValues(13, 25);

  // Experiencia
  String _experience = '3–5 años';

  void _apply() {
    Navigator.pop(context, {
      'recency': _recency,
      'jobTypes': _jobTypes.toList(),
      'levels': _levels.toList(),
      'cities': _selectedCities.toList(),
      'salaryMinK': _salary.start.round(),
      'salaryMaxK': _salary.end.round(),
      'experience': _experience,
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    Widget chipSet(String title, List<String> opts, Set<String> set) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: tt.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: opts.map((o){
              final sel = set.contains(o);
              return ChoiceChip(
                label: Text(o),
                selected: sel,
                onSelected: (_) => setState(() => sel ? set.remove(o) : set.add(o)),
                selectedColor: cs.primary.withOpacity(0.15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: cs.outlineVariant),
                ),
              );
            }).toList(),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtrar'),
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: ()=>Navigator.pop(context)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Última actualización
          Text('Última actualización', style: tt.titleMedium),
          ...['Reciente','Semana pasada','Mes pasado','Cualquier momento'].map((e)=>RadioListTile(
            title: Text(e), value: e, groupValue: _recency,
            onChanged: (v)=>setState(()=>_recency=v!),
          )),
          const Divider(height: 32),

          chipSet('Tipo de puesto de trabajo', ['En el sitio','Híbrido','Remoto'], _jobTypes),
          const SizedBox(height: 16),

          chipSet('Tipo de empleo', ['Prácticas','Medio jornada','Tiempo completo','Contrato','Por proyecto'], _jobTypes),
          const SizedBox(height: 16),

          chipSet('Nivel del puesto', ['Junior','Senior','Líder','Director'], _levels),
          const Divider(height: 32),

          Text('Ciudad', style: tt.titleMedium),
          const SizedBox(height: 8),
          ..._cities.map((c)=>CheckboxListTile(
            value: _selectedCities.contains(c),
            title: Text(c),
            onChanged: (v)=>setState(()=> v! ? _selectedCities.add(c) : _selectedCities.remove(c)),
          )),
          const Divider(height: 32),

          Text('Salario', style: tt.titleMedium),
          RangeSlider(
            min: 0, max: 50, divisions: 50,
            values: _salary,
            labels: RangeLabels('\$${_salary.start.round()}k','\$${_salary.end.round()}k'),
            onChanged: (v)=>setState(()=>_salary=v),
            activeColor: cs.primary,
          ),
          const SizedBox(height: 16),

          Text('Experiencia', style: tt.titleMedium),
          ...['Sin experiencia','Menos de un año','1–3 años','3–5 años','5–10 años','Más de 10 años']
            .map((e)=>RadioListTile(
              title: Text(e), value: e, groupValue: _experience,
              onChanged: (v)=>setState(()=>_experience=v!),
            )),
          const SizedBox(height: 16),

          Row(
            children: [
              OutlinedButton(onPressed: (){
                setState(() {
                  _recency = 'Cualquier momento';
                  _jobTypes..clear()..add('Tiempo completo');
                  _levels..clear()..add('Junior');
                  _selectedCities..clear()..add('California, USA');
                  _salary = const RangeValues(13,25);
                  _experience = '3–5 años';
                });
              }, child: const Text('Reset')),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: _apply,
                  child: const Text('APLICAR AHORA'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
