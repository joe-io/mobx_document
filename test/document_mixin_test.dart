import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart';

import 'models/order_document.dart';
import 'models/order_models.dart';
import 'test_widgets/order_view.dart';

void main() {

  test('basic undo/redo', () {
    final doc = new OrderDocument();
    // reaction( (_)=> doc.root, (_)=> print(doc.root?.customer?.name));

    // Set Customer
    doc.setCustomer(Person(name: "John Doe", age: 22));
    expect(doc.root.customer.name, "John Doe");

    // Update Customer Name
    doc.updateCustomerName("Jane Doe");
    doc.printStackTopItems('udpate name');
    expect(doc.root.customer.name, "Jane Doe");

    // Test Undo Name Change
    doc.undo();
    expect(doc.root.customer.name, "John Doe");

    // Test Undo Setting Customer
    doc.undo();
    expect(doc.root.customer, null);

    // Test Redo Setting Customer
    doc.redo();
    expect(doc.root.customer.name, "John Doe");

    // Test Redo Setting Name
    doc.printStackTopItems('before redo');
    doc.redo();
    doc.printStackTopItems('after redo');
    expect(doc.root.customer.name, "Jane Doe");
  });

  test('making changes after an undo, should reset the redo stack', () {
    final doc = new OrderDocument();

    // Set Customer
    doc.setCustomer(Person(name: "John Doe", age: 22));
    expect(doc.root.customer.name, "John Doe");

    // Update Customer Name
    doc.updateCustomerName("Jane Doe");
    expect(doc.root.customer.name, "Jane Doe");

    // Test Undo Name Change
    doc.undo();
    expect(doc.root.customer.name, "John Doe");
    expect(doc.redoStack.length, 1);

    // Change Name Again - redoStack should be reset
    doc.updateCustomerName("Bob Smith");
    expect(doc.root.customer.name, "Bob Smith");
    expect(doc.redoStack.length, 0);
  });

  testWidgets('rebuild flutter on undo/redo', (tester) async {
    // Setup the initial doc
    final doc = new OrderDocument();

    // Set initial customer
    doc.setCustomer(Person(name: "John Doe", age: 22));

    // Change the name
    doc.setCustomer(Person(name: "Jane Doe", age: 22));

    // Make sure it has the id we expect
    expect(doc.root.id, "123");

    // Render the component
    await tester.pumpWidget(new Directionality(
        textDirection: TextDirection.ltr,
        child: OrderDocumentView(
          doc: doc,
        )));

    // Make sure the doc id rendered
    final idFinder = find.text('ID: 123');
    expect(idFinder, findsOneWidget);

    // Make sure the customer name rendered
    final customerNameFinder = find.text('Customer Name: Jane Doe');
    expect(customerNameFinder, findsOneWidget);

    // Undo customer name change & pump
    doc.undo();
    await tester.pump();

    // Check that name has been undone
    final undoNameFinder = find.text('Customer Name: John Doe');
    expect(undoNameFinder, findsOneWidget);

    // Redo the name change & pump
    doc.redo();
    await tester.pump();

    // Check that name has been undone
    final redoNameFinder = find.text('Customer Name: Jane Doe');
    expect(redoNameFinder, findsOneWidget);
  });
}
