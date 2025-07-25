import 'package:flutter/material.dart';
import '../../domain/entities/purchase_entity.dart';

class PurchaseButton extends StatefulWidget {
  final PurchaseEntity purchase;
  final VoidCallback onPressed;
  final bool isLoading;

  const PurchaseButton({
    Key? key,
    required this.purchase,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  State<PurchaseButton> createState() => _PurchaseButtonState();
}

class _PurchaseButtonState extends State<PurchaseButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isHolding = false;
  static const int _holdDuration = 2000; // 2 секунды

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: _holdDuration),
      vsync: this,
    );
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startHold() {
    if (widget.isLoading) return;

    setState(() {
      _isHolding = true;
    });
    _animationController.forward();

    Future.delayed(const Duration(milliseconds: _holdDuration), () {
      if (_isHolding && mounted) {
        widget.onPressed();
        _resetHold();
      }
    });
  }

  void _resetHold() {
    if (mounted) {
      setState(() {
        _isHolding = false;
      });
      _animationController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: GestureDetector(
        onTapDown: (_) => _startHold(),
        onTapUp: (_) => _resetHold(),
        onTapCancel: _resetHold,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.7),
                  ],
                  stops: [0.0, _animation.value],
                ),
              ),
              child: ElevatedButton(
                onPressed: null, // Отключаем стандартное поведение
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadowColor: Colors.transparent,
                ),
                child: widget.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Column(
                        children: [
                          Text(
                            widget.purchase.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
