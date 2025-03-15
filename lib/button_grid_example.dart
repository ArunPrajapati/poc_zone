
class ButtonGridView extends StatelessWidget {
  const ButtonGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button Variants'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Adjust based on screen size
          childAspectRatio: 3, // Adjust for button height and width ratio
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: ButtonVariant.values.length,
        itemBuilder: (context, index) {
          final variant = ButtonVariant.values[index];

          return AppButton(
            label: Text(variant.toString().split('.').last),  // Display variant name as label
            onClick: () => print('${variant.toString().split('.').last} clicked'),
            variant: variant,
            prefixIconPath: (variant == ButtonVariant.primary || variant == ButtonVariant.primaryIconOnly) ? 'assets/icons/primary_icon.svg' : null,
            suffixIconPath: (variant == ButtonVariant.secondary || variant == ButtonVariant.tertiary) ? 'assets/icons/secondary_icon.svg' : null,
            isDisabled: false,
          );
        },
      ),
    );
  }
}
