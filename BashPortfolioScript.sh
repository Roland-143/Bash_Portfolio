#!/bin/bash

# idea, nothing fancy, just a little portfolio script to show off my skills. 
# It does have some basic interactivity, as well as a fun easter egg at the end.

# contact and info about me!
name="Nick Steltzner"
school="Purdue Northwest University"
contact="nsteltzner@gmail.com"
linkedIn="https://www.linkedin.com/in/nicholas-steltzner-500715302/"
github="https://github.com/Roland-143"

# yes/no variables
tea='y'
noTea='n'

# function to open urls based on OS
open_url() {
    local url="$1"
    if [[ -z "$url" ]]; then
        echo "usage: open_url <url>"
        return 1
    fi
    local os
    os=$(uname)
    case "$os" in
        Linux*) xdg-open "$url" ;; #Linux
        Darwin*) open "$url" ;;   #MacOS
        CYGWIN*|MINGW*|MSYS*) cmd.exe /C start "" "$url" ;; #Windows
        *) echo "Unsupported OS" 
        return 1
        ;;
    esac
}

wizard() { # wizard ascii art
    cat << "EOF"
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣤⣤⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣶⠟⠛⠉⠉⠉⠛⠻⢿⣶⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⣍⠻⢿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢧⣄⠛⢿⣶⣄⣠⡾⣧⡀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣷⣦⡉⠻⣫⣾⡽⣷⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠇⠀⠀⣀⣀⡀⠀⠀⠀⠀⣀⣀⡀⠀⠸⣿⠻⣿⣾⡿⠃⠹⣿⣷⡀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⠟⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠻⣿⣇⠀⠉⠀⠀⠀⠈⠛⠛⠒⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⠃⢀⣀⣠⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣀⡀⠘⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣶⡿⠿⠟⠋⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠙⠛⠿⢿⣶⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⢀⣠⣴⣾⠿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠿⣷⣦⣄⡀⠀⠀⠀⠀
    ⠀⣀⣴⣾⣿⣛⣁⣤⣤⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⣠⣤⣌⣛⣿⣷⣦⣀⠀
    ⣼⡿⣿⣿⣿⣿⣿⣿⠋⠉⢹⡿⠻⣿⣿⡶⠒⠒⠲⣶⣶⣶⣶⣶⣶⡶⠖⠒⠲⢾⣿⣿⠟⢿⡏⠉⠙⣿⣿⣿⣿⣿⣿⢿⣷
    ⢹⣷⡙⢿⣿⣿⠾⠍⠁⠀⣾⠇⠀⢻⠀⢈⣻⣷⣶⣤⣤⡽⠟⢯⣤⣤⣴⣾⣿⡁⠀⡟⠀⠘⣷⠀⠈⠩⠷⣿⣿⡿⢋⣾⡟
    ⠀⠙⢿⣶⣭⣛⡿⠷⠤⣼⠏⢠⢶⣾⠀⠀⠙⠓⢦⣼⣿⡇⠀⢸⣿⣧⣴⠟⠋⠀⠀⣿⡄⡄⠹⣧⠤⠾⠿⣛⣭⣴⡿⠋⠀
    ⠀⠀⠀⠈⠛⠻⠿⣷⣶⠟⢰⡏⢸⣇⠀⠀⠀⠈⠉⢉⣹⠇⠀⠘⣏⡉⠉⠁⠀⠀⠀⢸⡇⢹⡆⠻⣶⣾⠿⠟⠛⠉⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⢠⡏⢠⡟⠀⣼⣿⣄⠀⠀⠀⡼⠋⠻⠀⠀⠀⠾⠉⢳⡀⠀⠀⣠⣿⣷⠀⢹⡄⢹⣆⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⢀⣟⣠⡿⢀⣼⡇⢹⣝⡷⣤⣼⣳⠴⠛⠳⠤⠔⠛⠦⣞⣷⣤⢴⣫⡟⠸⣷⡀⢿⣄⣻⡀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠸⢋⣿⠁⣼⢹⣆⠀⠉⠛⠛⠉⠁⠀⠀⣀⣿⣄⠀⠀⠀⠉⠛⠛⠉⠀⢠⡏⢧⠀⢿⡝⠇⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⣼⡇⣰⠃⠈⢿⣦⣄⣀⣀⣀⣤⡴⠞⠋⠉⠉⠳⢦⣤⣀⣀⣀⣠⣴⡿⠁⠘⣦⢸⣷⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⢿⣿⡏⢠⠄⢸⣧⠉⠉⢻⣀⣠⡶⠞⠛⠉⠛⠳⢶⣤⣀⡟⠉⠉⢸⡇⠀⡄⢹⡿⠟⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⢸⣡⡏⠀⡄⢿⡀⠀⠀⠛⠉⠀⠀⠀⠀⠀⠀⠀⠉⠛⠁⠀⢀⡿⢡⡀⢹⣬⡇⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠸⡿⣇⢸⣿⢸⣷⣼⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣧⣾⡇⣼⣧⣸⢻⡇⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⠹⣿⡏⡿⣧⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣾⣿⠻⣿⠏⢿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠁⠀⠻⣿⣦⣾⠀⠀⠀⠀⠀⣶⣤⡟⠟⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⢻⣧⡀⠀⠀⣼⡿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢷⣦⡾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
EOF
}

cup() { # tea cup ascii art
    cat << "EOF"
      (((( 
        (((( 
         )))) 
      _ .---. 
     ( |`---'| 
      \|     | 
      : .___, :
       `-----' 
EOF
}


# Experience and other jazz
experience="I dabble in the arcane art of Computer Science with a concentration in AI Studies, that alongside a minor in Cybersecurity.
As of now I work as a Software Development Intern (Wizard's-Apprentice) at 365 Retail Markets, where I'm gaining hands-on wizarding experience in full-stack mobile development.
I expect to graduate my studies in the spring of 2027 and am actively seeking new projects and challenges to better my skills for life beyond graduation."

skills="Java, JavaScript, HTML & CSS, TypeScript, Linux, Bash, Git"
tools="Tools: VS-Code, GitHub, Jira, IntelliJ, Android Studio, XCode, Postman, MySQL Workbench"

# enterence of the script
echo -e "\nGreetings traveller! I welcome and thank you for visiting my humble little portfolio.\n"
echo -e "\nTales of old talk of a certain nomad that will stumble upon this humble little bash script."
echo -e "That fellow is destined to be granted a tour of my skills and experience, and I believe that person to be you!\n"
echo -e "\nQuickly now! Come inside and allow us to get aquanted."
read -p "Would you like some tea? [y/n]" teacheck

#4 generations of If statements to check for yes/no answers :D
if [[ "$teacheck" = 'y' || "$teacheck" = 'Y' ]];
then
    echo "______________________________________________________________"
    echo -e "\nWonderful! I will get that for you right away!\n"
    echo "..."    
    sleep 2
    echo -e "\nHere you are!\n"
    cup
    echo -e "\nBe careful it's hot."
    sleep 2
elif [[ "$teacheck" = 'n' || "$teacheck" = 'N' ]]; then
    echo "______________________________________________________________"
    echo -e "\nNo worries, I understand tea is not for everyone.\n"
else
    echo "______________________________________________________________"
    echo -e "\nIt seems as though you do not want tea, I will take that as a no.\n"
fi

echo -e "\nPlease grab a seat and get cozy, I would like to tell you a little about myself.\n"
echo -e "Now of course before I begin my ramblings, be honest, would you like to know more about me? [y/n]"
read -r knowmore

if [[ "$knowmore" = 'y' || "$knowmore" = 'Y' ]];
then
    echo "_____________________________________________________________"
    echo -e "\nWonderful!\n"
    echo -e "My name is $name, I am currently a wizarding student at $school.\n"
    echo -e "$experience\n"
    echo -e "If you would like to connect with me, I have my LinkedIn and GitHub available for you to view.\n"
    echo -e "Would you like me to open them for you? [y/n]"
    read -r contactCheck
    if [[ "$contactCheck" = 'y' || "$contactCheck" = 'Y' ]];
    then
        echo "_____________________________________________________________"
        echo -e "\nGreat! I will open my LinkedIn and GitHub for you now!"
        echo -e "If you desire to contact me, my email is $contact\n"
        sleep 1
        echo -e "Opening links now! HUZZAH! "
        sleep 2
        open_url "$linkedIn"
        open_url "$github"
        open_url "mailto:$contact"
    elif [[ "$contactCheck" = 'n' || "$contactCheck" = 'N' ]]; then
        echo "_____________________________________________________________"
        echo -e "\nNo worries, I understand."
        echo -e "\nIf you would like to send me a carrier bird or scry me, my email is $contact"
        echo -e "My LinkedIn is $linkedIn"
        echo -e "My GitHub is $github\n"
    else
        echo "_____________________________________________________________"
        echo -e "\nI'm sorry? I guess I will take that as a no...\n"
        sleep 2
        wizard
        sleep 1
    fi
    echo "_____________________________________________________________"
    echo -e "\nNow, onto the good stuff!"
    echo -e "Currently I have base knowledge in $skills, and I am always looking to improve!"
    echo -e "As my experience grows, so do my skills and tools I use!"
    echo -e "\nSpeaking of tools, I primarily have experience using: $tools"
    echo -e "\nThank you for taking the time to learn a little about me!"
    echo -e "If you would like to reach out, please do not hesitate to contact me!\n"
elif [[ "$knowmore" = 'n' || "$knowmore" = 'N' ]]; then
    echo "_____________________________________________________________"
    echo -e "\nAhhh, no worries, I understand not everyone enjoys the likes of my ramblings.\n"
    echo -e "If you change your mind, feel free to re-play this script!"
    echo -e "before you go, I have one last inquiry."
    echo -e "Would you like to see a magic trick? [y/n]"
    read -r magictrick
    if [[ "$magictrick" = 'y' || "$magictrick" = 'Y' ]]
    then
        echo -e "enjoy!"
        echo -e "\n"
        sleep 1
        open_url "https://www.youtube.com/watch?v=dQw4w9WgXcQ&list=RDdQw4w9WgXcQ&start_radio=1"
    fi
else
    echo -e "\nI will take that as a no....\n"
fi

