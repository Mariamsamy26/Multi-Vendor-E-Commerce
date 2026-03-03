import re, pathlib
path = pathlib.Path(r"g:\gosmart\Multi-Vendor-E-Commerce\lib\app\user_stories\orders_cycle\widget\order_details_widgets.dart")
text = path.read_text(encoding='utf-8')
pattern = re.compile(r"TextButton\([^}]*?Navigator\.of\(ctx\)\.pop\(\);.*?markNeedsBuild\(\);\s*\},\s*child: const Text\(\"Yes\"\),\s*\),", re.DOTALL)
replacement = r'''TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();

              # Double-check status before cancelling
              if (order.status == OrderStatus.delivered) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Cannot cancel a delivered order.")),
                );
                return;
              }

              # Update the order entry to cancelled
              final index = DummyOrders.orders.indexOf(order);
              if (index != -1) {
                DummyOrders.orders[index] = OrderModel(
                  id: order.id,
                  date: order.date,
                  status: OrderStatus.cancelled,
                  products: order.products,
                );
              }

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Order cancelled.")),
              );

              (context as Element).markNeedsBuild();
            },
            child: const Text("Yes"),
          ),'''
new_text, count = pattern.subn(replacement, text)
print('replacements:', count)
if count:
    path.write_text(new_text, encoding='utf-8')
    print('file updated')
else:
    print('pattern not found')
