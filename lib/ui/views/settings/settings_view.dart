import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:revanced_manager/constants.dart';
import 'package:revanced_manager/theme.dart';
import 'package:revanced_manager/ui/views/settings/settings_viewmodel.dart';
import 'package:revanced_manager/ui/widgets/settingsView/about_info_widget.dart';
import 'package:revanced_manager/ui/widgets/settingsView/custom_text_field.dart';
import 'package:revanced_manager/ui/widgets/settingsView/settings_switch_item.dart';
import 'package:revanced_manager/ui/widgets/settingsView/social_media_cards.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_themes/stacked_themes.dart';

class SettingsView extends StatelessWidget {
  final TextEditingController organizationController = TextEditingController();
  final TextEditingController patchesSourceController = TextEditingController();
  final TextEditingController integrationsSourceController =
      TextEditingController();

  SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => SettingsViewModel(),
      onModelReady: (model) => model.initialize(),
      builder: (context, SettingsViewModel model, child) => Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 60),
                  I18nText(
                    'settingsView.widgetTitle',
                    child: Text(
                      '',
                      style: GoogleFonts.inter(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SettingsSwitchItem(
                    title: 'settingsView.themeLabel',
                    subtitle: 'settingsView.themeHint',
                    value: isDark,
                    onTap: (value) {
                      isDark = value;
                      getThemeManager(context).toggleDarkLightTheme();
                    },
                  ),
                  ListTile(
                    title: I18nText(
                      'settingsView.rootModeLabel',
                      child: Text(
                        '',
                        style: kSettingItemTextStyle,
                      ),
                    ),
                    subtitle: I18nText('settingsView.rootModeHint'),
                    trailing: GestureDetector(
                      onTap: () {
                        model.navigateToRootChecker();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 1,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        child: Text(
                          model.isRooted ? 'Rooted' : 'Not rooted',
                        ),
                      ),
                    ),
                  ),
                  CustomTextField(
                    inputController: organizationController,
                    label: 'settingsView.organizationLabel',
                    hint: ghOrg,
                    onChanged: (value) {
                      ghOrg = value;
                    },
                  ),
                  CustomTextField(
                    inputController: patchesSourceController,
                    label: 'settingsView.patchesSourceLabel',
                    hint: patchesRepo,
                    onChanged: (value) {
                      patchesRepo = value;
                    },
                  ),
                  CustomTextField(
                    inputController: integrationsSourceController,
                    label: 'settingsView.integrationsSourceLabel',
                    hint: integrationsRepo,
                    onChanged: (value) {
                      integrationsRepo = value;
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        I18nText(
                          'settingsView.languageLabel',
                          child: Text('', style: kSettingItemTextStyle),
                        ),
                        DropdownButton(
                          value: 'en',
                          items: const [
                            DropdownMenuItem(
                              value: 'en',
                              child: Text('English'),
                            ),
                            DropdownMenuItem(
                              value: 'fr',
                              child: Text('French'),
                            ),
                          ],
                          onChanged: (value) {
                            value = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: I18nText(
                      'settingsView.contributorsLabel',
                      child: Text('', style: kSettingItemTextStyle),
                    ),
                    onTap: model.navigateToContributors,
                  ),
                  const SocialMediaCards(),
                  const AboutWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
