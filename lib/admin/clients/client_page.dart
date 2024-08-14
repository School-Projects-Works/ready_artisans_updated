import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_network/image_network.dart';
import 'package:ready_artisans/admin/provider/admin_provider.dart';
import 'package:ready_artisans/components/text_inputs.dart';

import '../../styles/app_colors.dart';
import '../../styles/styles_admin.dart';
import '../core/custom_dialog.dart';

class ClientPage extends ConsumerStatefulWidget {
  const ClientPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ClientPageState();
}

class _ClientPageState extends ConsumerState<ClientPage> {
  @override
  Widget build(BuildContext context) {
    var style = Styles(context);
    var titleStyles = style.title(color: Colors.white, fontSize: 15);
    var rowStyles = style.body(fontSize: 13);
    var clients = ref.watch(clientFilterProvider).filter;
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Registered Artisans'.toUpperCase(),
              style: style.title(fontSize: 30, color: primaryColor)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: style.width * 0.5,
                child: CustomTextFields(
                  hintText: 'Search customer',
                  onChanged: (query) {
                    ref
                        .read(clientFilterProvider.notifier)
                        .filterClients(query);
                  },
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: DataTable2(
              columnSpacing: 30,
              horizontalMargin: 12,
              empty: Center(
                  child: Text(
                'No Artisan found',
                style: rowStyles,
              )),
              minWidth: 600,
              headingRowColor: WidgetStateColor.resolveWith(
                  (states) => primaryColor.withOpacity(0.6)),
              headingTextStyle: titleStyles,
              columns: [
                DataColumn2(
                  label: Text(
                    'Ghana Card'.toUpperCase(),
                    style: titleStyles,
                  ),
                ),
                DataColumn2(
                  label: Text('Image'.toUpperCase()),
                ),
                DataColumn2(
                  label: Text('Name'.toUpperCase()),
                ),
                DataColumn2(
                  label: Text('Phone'.toUpperCase()),
                ),
                DataColumn2(
                  label: Text('address'.toUpperCase()),
                ),
                DataColumn2(
                  label: Text('status'.toUpperCase()),
                ),
                DataColumn2(
                  label: Text('Action'.toUpperCase()),
                ),
              ],
              rows: List<DataRow>.generate(clients.length, (index) {
                var client = clients[index];
                return DataRow(
                  cells: [
                    DataCell(Text(client.idNumber, style: rowStyles)),
                    DataCell(
                      client.image.isEmpty
                          ? const Icon(Icons.image)
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: ImageNetwork(
                                  image: client.image,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                    ),
                    DataCell(Text(client.name, style: rowStyles)),
                    DataCell(Text(client.phone, style: rowStyles)),
                    DataCell(Text(client.address, style: rowStyles)),
                    DataCell(
                      Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: client.status == 'active'
                                  ? Colors.green
                                  : client.status == 'pending'
                                      ? Colors.orange
                                      : Colors.red,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(client.status,
                              style: rowStyles.copyWith(color: Colors.white))),
                    ),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_red_eye),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 2),
                          if (client.status == 'active')
                            IconButton(
                              tooltip: 'Ban Customer',
                              icon: const Icon(Icons.block),
                              onPressed: () {
                                CustomAdminDialog.showInfo(
                                    message:
                                        'Are you sure you want to ban this customer?',
                                    buttonText: 'Ban',
                                    onPressed: () {
                                      ref
                                          .read(clientFilterProvider.notifier)
                                          .updateStatus(client.copyWith(
                                              status: 'banned'));
                                    });
                              },
                            ),
                          if (client.status == 'banned' ||
                              client.status == 'pending')
                            IconButton(
                              tooltip: 'Activate Customer',
                              icon: const Icon(Icons.check),
                              onPressed: () {
                                CustomAdminDialog.showInfo(
                                    message:
                                        'Are you sure you want to activate this customer?',
                                    buttonText: 'activate',
                                    onPressed: () {
                                      ref
                                          .read(clientFilterProvider.notifier)
                                          .updateStatus(client.copyWith(
                                              status: 'active'));
                                    });
                              },
                            ),
                        ],
                      ),
                    )
                  ],
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
