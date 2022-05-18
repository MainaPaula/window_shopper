import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const Text('Privacy Policy',style: TextStyle(fontSize: 36, color: Colors.black, fontWeight: FontWeight.bold)),
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
                  Text("At WindowShopper, accessible from windowshopper.com, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by WindowShopper and how we use it.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),
                  SizedBox(height: 10),
                  Text("If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("This Privacy Policy applies only to our online activities and is valid for visitors to our website with regards to the information that they shared and/or collect in WindowShopper. This policy is not applicable to any information collected offline or via channels other than this website",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("Consent", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.justify,),

                  SizedBox(height: 10),
                  Text("By using our website, you hereby consent to our Privacy Policy and agree to its terms.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("Information we collect", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

                  SizedBox(height: 10),
                  Text("The personal information that you are asked to provide, and the reasons why you are asked to provide it, will be made clear to you at the point we ask you to provide your personal information.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("If you contact us directly, we may receive additional information about you such as your name, email address, phone number, the contents of the message and/or attachments you may send us, and any other information you may choose to provide.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("When you register for an Account, we may ask for your contact information, including items such as name, company name, address, email address, and telephone number.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("How we use your information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

                  SizedBox(height: 10),
                  Text("We use the information we collect in various ways, including to:"
                      " - Provide, operate, and maintain our website"
                      " - Improve, personalize, and expand our website"
                      " - Understand and analyze how you use our website"
                      " - Develop new products, services, features, and functionality"
                      " - Communicate with you, either directly or through one of our partners, including for customer service, to provide you with updates and other information relating to the website, and for marketing and promotional purposes"
                      " - Send you emails"
                      " - Find and prevent fraud",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("Log Files", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

                  SizedBox(height: 10),
                  Text("WindowShopper follows a standard procedure of using log files. These files log visitors when they visit websites. All hosting companies do this and a part of hosting services' analytics. The information collected by log files include internet protocol (IP) addresses, browser type, Internet Service Provider (ISP), date and time stamp, referring/exit pages, and possibly the number of clicks. These are not linked to any information that is personally identifiable. The purpose of the information is for analyzing trends, administering the site, tracking users' movement on the website, and gathering demographic information.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("Cookies and Web Beacons", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

                  SizedBox(height: 10),
                  Text("Like any other website, WindowShopper uses 'cookies'. These cookies are used to store information including visitors' preferences, and the pages on the website that the visitor accessed or visited. The information is used to optimize the users' experience by customizing our web page content based on visitors' browser type and/or other information.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("Our Advertising Partners", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

                  SizedBox(height: 10),
                  Text("Some of advertisers on our site may use cookies and web beacons. Our advertising partners are listed below. Each of our advertising partners has their own Privacy Policy for their policies on user data. For easier access, we hyperlinked to their Privacy Policies. Google: https://policies.google.com/technologies/ads",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("Advertising Partners Privacy Policies", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

                  SizedBox(height: 10),
                  Text("You may consult this list to find the Privacy Policy for each of the advertising partners of WindowShopper.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("Third-party ad servers or ad networks uses technologies like cookies, JavaScript, or Web Beacons that are used in their respective advertisements and links that appear on WindowShopper, which are sent directly to users' browser. They automatically receive your IP address when this occurs. These technologies are used to measure the effectiveness of their advertising campaigns and/or to personalize the advertising content that you see on websites that you visit.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("Note that WindowShopper has no access to or control over these cookies that are used by third-party advertisers.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("Third Party Privacy Policies", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

                  SizedBox(height: 10),
                  Text("WindowShopper's Privacy Policy does not apply to other advertisers or websites. Thus, we are advising you to consult the respective Privacy Policies of these third-party ad servers for more detailed information. It may include their practices and instructions about how to opt-out of certain options.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("You can choose to disable cookies through your individual browser options. To know more detailed information about cookie management with specific web browsers, it can be found at the browsers' respective websites.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("CCPA Privacy Rights (Do Not Sell My Personal Information)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

                  SizedBox(height: 10),
                  Text("Under the CCPA, among other rights, California consumers have the right to:",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("Request that a business that collects a consumer's personal data disclose the categories and specific pieces of personal data that a business has collected about consumers.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("Request that a business delete any personal data about the consumer that a business has collected.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("Request that a business that sells a consumer's personal data, not sell the consumer's personal data.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("If you make a request, we have one month to respond to you. If you would like to exercise any of these rights, please contact us.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("GDPR Data Protection Rights", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

                  SizedBox(height: 10),
                  Text("We would like to make sure you are fully aware of all of your data protection rights. Every user is entitled to the following:",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("The right to access – You have the right to request copies of your personal data. We may charge you a small fee for this service.\n\nThe right to rectification – You have the right to request that we correct any information you believe is inaccurate. You also have the right to request that we complete the information you believe is incomplete.\n"
                      "The right to erasure – You have the right to request that we erase your personal data, under certain conditions.\n\nThe right to restrict processing – You have the right to request that we restrict the processing of your personal data, under certain conditions.\n\n"
                      "The right to object to processing – You have the right to object to our processing of your personal data, under certain conditions.\n\nThe right to data portability – You have the right to request that we transfer the data that we have collected to another organization, or directly to you, under certain conditions.\n\n"
                      "If you make a request, we have one month to respond to you. If you would like to exercise any of these rights, please contact us.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),

                  SizedBox(height: 10),
                  Text("Children's Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

                  SizedBox(height: 10),
                  Text("Another part of our priority is adding protection for children while using the internet. We encourage parents and guardians to observe, participate in, and/or monitor and guide their online activity.\n\n"
                      "WindowShopper does not knowingly collect any Personal Identifiable Information from children under the age of 13. If you think that your child provided this kind of information on our website, we strongly encourage you to contact us immediately and we will do our best efforts to promptly remove such information from our records.",
                      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),
                ],
              ),


            ),
          ),
        ));
  }
}
