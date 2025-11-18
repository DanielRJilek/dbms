import { TitlePage } from ".titlepage.js"

class View {
    constructor() {

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