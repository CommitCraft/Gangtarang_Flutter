import 'package:flutter/material.dart';

class PriceRange extends StatelessWidget {
  final String label;
  final double min;
  final double max;

  const PriceRange({required this.label, required this.min, required this.max});
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class PriceRangeSlider extends StatefulWidget {
  final List<PriceRange> priceRanges;
  final void Function(double, double)? onChanged;
  final TextStyle? labelStyle;
  final Color? activeColor;
  final Color? inactiveColor;

  const PriceRangeSlider({
    Key? key,
    required this.priceRanges,
    this.onChanged,
    this.labelStyle,
    this.activeColor,
    this.inactiveColor,
  }) : super(key: key);

  @override
  State<PriceRangeSlider> createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  late RangeValues _values;
  int _selectedRangeIndex = 0;

  @override
  void initState() {
    super.initState();
    _updateValuesFromSelectedRange();
  }

  void _updateValuesFromSelectedRange() {
    final selectedRange = widget.priceRanges[_selectedRangeIndex];
    _values = RangeValues(selectedRange.min, selectedRange.max);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
       
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${_values.start.toStringAsFixed(0)}',
                style: widget.labelStyle ??
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '\$${_values.end.toStringAsFixed(0)}',
                style: widget.labelStyle ??
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SliderTheme(
          data: SliderThemeData(
            rangeThumbShape: CustomRangeThumbShape(
              enabledThumbRadius: 10,
              primaryColor: widget.activeColor ?? Colors.blue,
            ),
            overlayShape: const RoundSliderOverlayShape(
              overlayRadius: 16,
            ),
            activeTrackColor: widget.activeColor ?? Colors.blue,
            inactiveTrackColor: widget.inactiveColor ?? Colors.grey[300],
            thumbColor: Colors.white,
            overlayColor: (widget.activeColor ?? Colors.blue).withOpacity(0.2),
          ),
          child: RangeSlider(
            values: _values,
            min: widget.priceRanges[_selectedRangeIndex].min,
            max: widget.priceRanges[_selectedRangeIndex].max,
            onChanged: (RangeValues values) {
              setState(() {
                _values = values;
              });
              widget.onChanged?.call(values.start, values.end);
            },
          ),
        ),
      ],
    );
  }
}

// Example usage:
class ExampleScreen extends StatelessWidget {
  const ExampleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PriceRangeSlider(
          priceRanges: [
            PriceRange(label: '\$', min: 0, max: 100),
            PriceRange(label: '\$\$', min: 100, max: 500),
            PriceRange(label: '\$\$\$', min: 500, max: 1000),
          ],
          activeColor: Colors.blue,
          inactiveColor: Colors.grey[300],
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          onChanged: (start, end) {
            print('Price range: \$${start.toStringAsFixed(0)} - \$${end.toStringAsFixed(0)}');
          },
        ),
      ),
    );
  }
}

class CustomRangeThumbShape extends RangeSliderThumbShape {
  final double enabledThumbRadius;
  final Color primaryColor;

  const CustomRangeThumbShape({
    required this.enabledThumbRadius,
    required this.primaryColor,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(enabledThumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool isOnTop = false,
    bool isPressed = false,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
    bool? isStart,
  }) {
    final Canvas canvas = context.canvas;

    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = primaryColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, enabledThumbRadius, fillPaint);
    canvas.drawCircle(center, enabledThumbRadius, borderPaint);
  }
}

