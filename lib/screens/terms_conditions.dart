import 'package:flutter/material.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('Terms and Conditions',style: TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold)),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.redAccent),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text("Welcome to WindowShopper!\n\nThese terms and conditions outline the rules and regulations for the use of WindowShopper's Website, located at windowshopper.com.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),
                  SizedBox(height: 10),
                  Text("The following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice and all Agreements: 'Client', 'You' and 'Your' refers to you, the person log on this website and compliant to the Company’s terms and conditions. 'The Company', 'Ourselves', 'We', 'Our' and 'Us', refers to our Company. 'Party', 'Parties', or 'Us', refers to both the Client and ourselves. All terms refer to the offer, acceptance and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner for the express purpose of meeting the Client’s needs in respect of provision of the Company’s stated services, in accordance with and subject to, prevailing law of Netherlands. Any use of the above terminology or other words in the singular, plural, capitalization and/or he/she or they, are taken as interchangeable and therefore as referring to same.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),


                  SizedBox(height: 10),
                  Text("Cookies", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.justify,),

                  SizedBox(height: 10),
                  Text("We employ the use of cookies. By accessing WindowShopper, you agreed to use cookies in agreement with the WindowShopper's Privacy Policy.\n\nMost interactive websites use cookies to let us retrieve the user’s details for each visit. Cookies are used by our website to enable the functionality of certain areas to make it easier for people visiting our website. Some of our affiliate/advertising partners may also use cookies.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("License", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

                  SizedBox(height: 10),
                  Text("Unless otherwise stated, WindowShopper and/or its licensors own the intellectual property rights for all material on WindowShopper. All intellectual property rights are reserved. You may access this from WindowShopper for your own personal use subjected to restrictions set in these terms and conditions.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("You must not:\n\n"
                      "- Republish material from WindowShopper\n"
                      "- Sell, rent or sub-license material from WindowShopper\n"
                      "- Reproduce, duplicate or copy material from WindowShopper\n"
                      "- Redistribute content from WindowShopper",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("This Agreement shall begin on the date hereof. Our Terms and Conditions were created with the help of the Terms And Conditions Template.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),


                  SizedBox(height: 10),
                  Text("Parts of this website offer an opportunity for users to post and exchange opinions and information in certain areas of the website. WindowShopper does not filter, edit, publish or review Comments prior to their presence on the website. Comments do not reflect the views and opinions of WindowShopper,its agents and/or affiliates. Comments reflect the views and opinions of the person who post their views and opinions. To the extent permitted by applicable laws, WindowShopper shall not be liable for the Comments or for any liability, damages or expenses caused and/or suffered as a result of any use of and/or posting of and/or appearance of the Comments on this website\n\nWindowShopper reserves the right to monitor all Comments and to remove any Comments which can be considered inappropriate, offensive or causes breach of these Terms and Conditions.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("You warrant and represent that:\n\n"
                      "- You are entitled to post the Comments on our website and have all necessary licenses and consents to do so;\n"
                      "- The Comments do not invade any intellectual property right, including without limitation copyright, patent or trademark of any third party;\n"
                      "- The Comments do not contain any defamatory, libelous, offensive, indecent or otherwise unlawful material which is an invasion of privacy\n"
                      "- The Comments will not be used to solicit or promote business or custom or present commercial activities or unlawful activity.\n\n"
                      "You hereby grant WindowShopper a non-exclusive license to use, reproduce, edit and authorize others to use, reproduce and edit any of your Comments in any and all forms, formats or media.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("Hyperlinking to our Content", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

                  SizedBox(height: 10),
                  Text("The following organizations may link to our Website without prior written approval: \nGovernment agencies;\n"
                      "Search engines;\n"
                      "News organizations;\n"
                      "Online directory distributors may link to our Website in the same manner as they hyperlink to the Websites of other listed businesses; and\n"
                      "System wide Accredited Businesses except soliciting non-profit organizations, charity shopping malls, and charity fundraising groups which may not hyperlink to our Web site."
                      "\n\nThese organizations may link to our home page, to publications or to other Website information so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products and/or services; and (c) fits within the context of the linking party’s site.\n\n"
                      "We will approve link requests from these organizations if we decide that: (a) the link would not make us look unfavorably to ourselves or to our accredited businesses; (b) the organization does not have any negative records with us; (c) the benefit to us from the visibility of the hyperlink compensates the absence of WindowShopper; and (d) the link is in the context of general resource information.\n\n"
                      "We will approve link requests from these organizations if we decide that: (a) the link would not make us look unfavorably to ourselves or to our accredited businesses; (b) the organization does not have any negative records with us; (c) the benefit to us from the visibility of the hyperlink compensates the absence of WindowShopper; and (d) the link is in the context of general resource information.\n\n"
                      "These organizations may link to our home page so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products or services; and (c) fits within the context of the linking party’s site.\n\n"
                      "If you are one of the organizations listed in paragraph 2 above and are interested in linking to our website, you must inform us by sending an e-mail to WindowShopper. Please include your name, your organization name, contact information as well as the URL of your site, a list of any URLs from which you intend to link to our Website, and a list of the URLs on our site to which you would like to link. Wait 2-3 weeks for a response.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("iFrames", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

                  SizedBox(height: 10),
                  Text("Without prior approval and written permission, you may not create frames around our Webpages that alter in any way the visual presentation or appearance of our Website.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("Content Liability", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

                  SizedBox(height: 10),
                  Text("We shall not be hold responsible for any content that appears on your Website. You agree to protect and defend us against all claims that is rising on your Website. No link(s) should appear on any Website that may be interpreted as libelous, obscene or criminal, or which infringes, otherwise violates, or advocates the infringement or other violation of, any third party rights.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("Reservation of Rights", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

                  SizedBox(height: 10),
                  Text("We reserve the right to request that you remove all links or any particular link to our Website. You approve to immediately remove all links to our Website upon request. We also reserve the right to amen these terms and conditions and it’s linking policy at any time. By continuously linking to our Website, you agree to be bound to and follow these linking terms and conditions.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("Removal of links from our website)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

                  SizedBox(height: 10),
                  Text("If you find any link on our Website that is offensive for any reason, you are free to contact and inform us any moment. We will consider requests to remove links but we are not obligated to or so or to respond to you directly.\n\n"
                      "We do not ensure that the information on this website is correct, we do not warrant its completeness or accuracy; nor do we promise to ensure that the website remains available or that the material on the website is kept up to date.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),


                  SizedBox(height: 10),
                  Text("Disclaimer", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

                  SizedBox(height: 10),
                  Text("To the maximum extent permitted by applicable law, we exclude all representations, warranties and conditions relating to our website and the use of this website. Nothing in this disclaimer will:",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("- limit or exclude our or your liability for death or personal injury;\n"
                      "- limit or exclude our or your liability for fraud or fraudulent misrepresentation;"
                      "- limit any of our or your liabilities in any way that is not permitted under applicable law; or\n"
                      "- exclude any of our or your liabilities that may not be excluded under applicable law.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("in this Section and elsewhere in this disclaimer: (a) are subject to the preceding paragraph; and (b) govern all liabilities arising under the disclaimer, including liabilities arising in contract, in tort and for breach of statutory duty.\n\n"
                      "As long as the website and the information and services on the website are provided free of charge, we will not be liable for any loss or damage of any nature.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),
                ],
              ),


            ),
          ),
        ));
  }
}
