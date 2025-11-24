import { LoginPage } from "./pages/loginpage.js"

class View {
    constructor() {
        this.container = document.querySelector(".container");
        this.page = null;
    }

    clearPage() {
        while (this.container.firstChild) {
            this.container.lastChild.remove();
        }
    }

    renderLoginPage() {
        this.clearPage();
        const loginPage = new LoginPage(this, this.container);
        loginPage.render();
    }

    renderOptionsPage() {
        this.clearPage();
        const optionsPage = new OptionsPage(this, this.container);
        optionsPage.render();
    }

    renderFlightsMenu() {
    }

    renderCustomersMenu() {}

    renderStaffMenu() {}

    renderAircraftMenu() {}
}

export {View}