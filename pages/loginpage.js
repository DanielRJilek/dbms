class LoginPage{
    constructor(view, container) {
        this.container = container;
        this.view = view;
    }

    static connect(form) {
        let mysql = require('mysql');
        let connection = mysql.createConnection({
            host: 'localhost',
            user: userinput,
            password: passinput
        });
        connection.connect(function(err) {
            if (err) throw err;
            this.view.renderOptionsPage();
        });
    }

    createTitle(login_page) {
        const title = document.createElement("div");
        title.textContent = "Airport Management System";
        title.setAttribute("id", "title");
        login_page.appendChild(title);
    }

    createForm(login_page) {
        const form = document.createElement("form");
        form.setAttribute("action", "javascript:loginpage")
        form.setAttribute("onsubmit", "connect(this)");
        form.setAttribute("id", "login-form");

        const userlabel = document.createElement("label");
        userlabel.setAttribute("for", "userinput");
        userlabel.textContent = "Username";
        const userinput = document.createElement("input");
        userinput.setAttribute("type", "text");
        userinput.setAttribute("id", "userinput");
        userinput.setAttribute("name", "userinput");

        const passlabel = document.createElement("label");
        passlabel.setAttribute("for", "passinput");
        passlabel.textContent = "Password:";
        const passinput = document.createElement("input");
        passinput.setAttribute("type", "password");
        passinput.setAttribute("id", "passinput");
        passinput.setAttribute("name", "passinput");

        const login = document.createElement("input");
        login.setAttribute("type", "submit");
        login.setAttribute("value", "Log In");

        form.appendChild(userlabel);
        form.appendChild(userinput);
        form.appendChild(passlabel);
        form.appendChild(passinput);
        form.appendChild(login);
        login_page.appendChild(form);
    }

    render() {
        const login_page = document.createElement("div");
        login_page.setAttribute("id", "login-page");
        login_page.classList.add("page");
        this.createTitle(login_page);
        this.createForm(login_page);
        this.container.appendChild(login_page);
    }

    

}

export {LoginPage}