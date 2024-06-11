part of 'utils.dart';

class AppAlerts {
  const AppAlerts._();

  static displaySnackBar(BuildContext context, String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8).w,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8).w,
          decoration: BoxDecoration(
            color: isSuccess ? appColor.success100 : appColor.error100,
            borderRadius: Dimensions.kBorderRadiusAllSmallest,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(isSuccess ? Icons.task_alt_rounded : Icons.error,
                  color: isSuccess ? appColor.success600 : appColor.error600),
              Dimensions.kHorizontalSpaceSmaller,
              Expanded(
                child: Text(
                  message,
                  style: context.textTheme.bodySmall?.copyWith(
                      color:
                          isSuccess ? appColor.success600 : appColor.error600),
                ),
              ),
            ],
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  static displayErrorAlert(BuildContext context, String title, String message) {
    showAdaptiveDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          Future.delayed(
              const Duration(seconds: 2), () => Navigator.of(context).pop());
          return AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: const EdgeInsets.all(0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                topContainer(
                  context: context,
                  backgroundColor: appColor.error600,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium
                        ?.copyWith(color: appColor.white),
                  ),
                ),
                bottomContainer(
                  context: context,
                  child: Column(
                    children: [
                      Dimensions.kVerticalSpaceSmallest,
                      Lottie.asset(repeat: false, AppLottie.error, width: 70),
                      Dimensions.kVerticalSpaceSmall,
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodySmall
                            ?.copyWith(color: appColor.error600),
                      ),
                      Dimensions.kVerticalSpaceLarge,
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  static displayWarningAlert(
      BuildContext context, String title, String message) {
    showAdaptiveDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          Future.delayed(
              const Duration(seconds: 2), () => Navigator.of(context).pop());
          return AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: const EdgeInsets.all(0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                topContainer(
                  context: context,
                  backgroundColor: appColor.warning600,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium
                        ?.copyWith(color: appColor.white),
                  ),
                ),
                bottomContainer(
                  context: context,
                  child: Column(
                    children: [
                      Dimensions.kVerticalSpaceSmallest,
                      Lottie.asset(repeat: false, AppLottie.warning, width: 70),
                      Dimensions.kVerticalSpaceSmall,
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodySmall
                            ?.copyWith(color: appColor.warning600),
                      ),
                      Dimensions.kVerticalSpaceLarge,
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  static displaySuccessAlert(
      BuildContext context, String title, String message) {
    showAdaptiveDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          Future.delayed(const Duration(seconds: 2),
              () => {Navigator.of(context).pop(true)});
          return AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: const EdgeInsets.all(0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                topContainer(
                  context: context,
                  backgroundColor: appColor.success600,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium
                        ?.copyWith(color: appColor.white),
                  ),
                ),
                bottomContainer(
                  context: context,
                  child: Column(
                    children: [
                      Dimensions.kVerticalSpaceSmallest,
                      Lottie.asset(repeat: false, AppLottie.success, width: 70),
                      Dimensions.kVerticalSpaceSmall,
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodySmall
                            ?.copyWith(color: appColor.success600),
                      ),
                      Dimensions.kVerticalSpaceLarge,
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  static displayLogoutAlert(
      {required BuildContext context, required VoidCallback onPressed}) {
    showAdaptiveDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: const EdgeInsets.all(0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                topContainer(
                  context: context,
                  backgroundColor: appColor.brand600,
                  child: Text(
                    "Log out",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium?.copyWith(
                        color: appColor.white, fontWeight: FontWeight.bold),
                  ),
                ),
                bottomContainer(
                  context: context,
                  child: Column(
                    children: [
                      Dimensions.kVerticalSpaceSmallest,
                      Text(
                        "Are you sure you want to logout ?",
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodySmall
                            ?.copyWith(color: appColor.brand800),
                      ),
                      Dimensions.kVerticalSpaceLarge,
                      Row(
                        children: [
                          Dimensions.kHorizontalSpaceMedium,
                          Expanded(
                            child: ActionButton(
                              height: 44,
                              onPressed: () => Navigator.pop(context),
                              color: appColor.error600,
                              child: Text(
                                "No",
                                textAlign: TextAlign.center,
                                style: context.textTheme.bodySmall
                                    ?.copyWith(color: appColor.white),
                              ),
                            ),
                          ),
                          Dimensions.kHorizontalSpaceSmall,
                          Expanded(
                            child: ActionButton(
                              height: 44,
                              onPressed: onPressed,
                              color: appColor.success600,
                              child: Text(
                                "Yes",
                                textAlign: TextAlign.center,
                                style: context.textTheme.bodySmall
                                    ?.copyWith(color: appColor.white),
                              ),
                            ),
                          ),
                          Dimensions.kHorizontalSpaceMedium,
                        ],
                      ),
                      Dimensions.kVerticalSpaceSmallest,
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  static displayFencingAlert(
      {required BuildContext context, required VoidCallback onPressed}) {
    showAdaptiveDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: const EdgeInsets.all(0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                topContainer(
                  context: context,
                  backgroundColor: appColor.brand600,
                  child: Text(
                    "Fencing Alert",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium?.copyWith(
                        color: appColor.white, fontWeight: FontWeight.bold),
                  ),
                ),
                bottomContainer(
                  context: context,
                  child: Column(
                    children: [
                      Dimensions.kVerticalSpaceSmallest,
                      Lottie.asset(AppLottie.location, width: 90),
                      Text(
                        "You are out of the coverage area.",
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodySmall
                            ?.copyWith(color: appColor.brand800),
                      ),
                      Dimensions.kVerticalSpaceLarge,
                      Row(
                        children: [
                          Expanded(child: Container()),
                          Dimensions.kHorizontalSpaceSmall,
                          Expanded(
                            child: ActionButton(
                              height: 44,
                              onPressed: onPressed,
                              color: appColor.error600,
                              child: Text(
                                "OK",
                                textAlign: TextAlign.center,
                                style: context.textTheme.bodySmall
                                    ?.copyWith(color: appColor.white),
                              ),
                            ),
                          ),
                          Dimensions.kHorizontalSpaceSmall,
                          Expanded(child: Container()),
                        ],
                      ),
                      Dimensions.kVerticalSpaceSmallest,
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  static displayExitAppAlert({required BuildContext context}) {
    return showAdaptiveDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: const EdgeInsets.all(0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                topContainer(
                  context: context,
                  backgroundColor: appColor.brand800,
                  child: Text(
                    "Exit App",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium?.copyWith(
                        color: appColor.white, fontWeight: FontWeight.bold),
                  ),
                ),
                bottomContainer(
                  context: context,
                  child: Column(
                    children: [
                      Dimensions.kVerticalSpaceSmallest,
                      Text(
                        "Are you sure you want to exit the app.",
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodySmall
                            ?.copyWith(color: appColor.brand800),
                      ),
                      Dimensions.kVerticalSpaceLarge,
                      Row(
                        children: [
                          Dimensions.kHorizontalSpaceMedium,
                          Expanded(
                            child: ActionButton(
                              height: 44,
                              onPressed: () => Navigator.of(context).pop(false),
                              color: appColor.error600,
                              child: Text(
                                "No",
                                textAlign: TextAlign.center,
                                style: context.textTheme.bodySmall
                                    ?.copyWith(color: appColor.white),
                              ),
                            ),
                          ),
                          Dimensions.kHorizontalSpaceSmall,
                          Expanded(
                            child: ActionButton(
                              height: 44,
                              onPressed: () => Navigator.of(context).pop(true),
                              color: appColor.success600,
                              child: Text(
                                "Yes",
                                textAlign: TextAlign.center,
                                style: context.textTheme.bodySmall
                                    ?.copyWith(color: appColor.white),
                              ),
                            ),
                          ),
                          Dimensions.kHorizontalSpaceMedium,
                        ],
                      ),
                      Dimensions.kVerticalSpaceSmallest,
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  static topContainer(
      {required BuildContext context,
      required Color backgroundColor,
      required Widget child}) {
    return Container(
      padding: Dimensions.kPaddingAllSmall,
      width: context.deviceSize.width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ).w,
      ),
      child: child,
    );
  }

  static bottomContainer(
      {required BuildContext context,
      required Widget child,
      EdgeInsetsGeometry? padding}) {
    return Container(
      width: context.deviceSize.width,
      padding: padding ?? Dimensions.kPaddingAllMedium,
      decoration: BoxDecoration(
        color: appColor.gray50,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ).w,
      ),
      child: child,
    );
  }

  static displayContentListAlert(
      {required BuildContext context,
      required String title,
      required Widget child}) {
    showAdaptiveDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: const EdgeInsets.all(0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              topContainer(
                context: context,
                backgroundColor: appColor.brand600,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium
                      ?.copyWith(color: appColor.white),
                ),
              ),
              bottomContainer(
                  context: context, child: child, padding: EdgeInsets.zero),
            ],
          ),
        );
      },
    );
  }
}
