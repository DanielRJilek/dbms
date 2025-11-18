import { TitlePage } from "./titlepage.js"

class View {
    constructor(container) {
        this.container = document.querySelector(".container");
        this.page = null;
    }

    clearPage() {
        while (this.container.firstChild) {
            this.container.lastChild.remove();
        }
    }

    renderTitlePage() {
        this.clearPage();
        const titlePage = new TitlePage(this, this.container);
        titlePage.render();
    }

    renderFlightsMenu() {
    }

    renderCustomersMenu() {}

    renderStaffMenu() {}

    renderAircraftMenu() {}
}

export {View}