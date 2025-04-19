  /*
      X-Wing Squad Builder 2.5
      Stephen Kim <raithos@gmail.com>
      https://yasb.app
  */
  /*
      X-Wing Squad Builder 2.5
      Stephen Kim <raithos@gmail.com>
      https://yasb.app
  */
  /*
      X-Wing Card Browser
      Geordan Rosario <geordan@gmail.com>
      https://github.com/geordanr/xwing
      Advanced search by Patrick Mischke
      https://github.com/patschke
  */
var DFL_LANGUAGE, GenericAddon, SERIALIZATION_CODE_TO_CLASS, SHOW_DEBUG_OUT_MISSING_TRANSLATIONS, SPEC_URL, SQUAD_DISPLAY_NAME_MAX_LENGTH, SQUAD_TO_XWS_URL, Ship, TYPES, URL_BASE, all, builders, byName, byPoints, conditionToHTML, exportObj, getPrimaryFaction, statAndEffectiveStat,
  indexOf = [].indexOf,
  hasProp = {}.hasOwnProperty;

exportObj = typeof exports !== "undefined" && exports !== null ? exports : this;

exportObj.SquadBuilderBackend = class SquadBuilderBackend {
  /*
      Usage:

          rebel_builder = new SquadBuilder
              faction: 'Rebel Alliance'
              ...
          empire_builder = new SquadBuilder
              faction: 'Galactic Empire'
              ...
          backend = new SquadBuilderBackend
              server: 'https://xwing.example.com'
              builders: [ rebel_builder, empire_builder ]
              login_logout_button: '#login-logout'
              auth_status: '#auth-status'

  */
  constructor(args) {
    var builder, j, len, ref;
    this.maybeAuthenticationChanged = this.maybeAuthenticationChanged.bind(this);
    this.nameCheck = this.nameCheck.bind(this);
    this.getLanguagePreference = this.getLanguagePreference.bind(this);
    this.getCollectionCheck = this.getCollectionCheck.bind(this);
    // Might as well do this right away
    $.ajaxSetup({
      dataType: "json", // Because Firefox sucks for some reason
      xhrFields: {
        withCredentials: true
      }
    });
    // args
    this.server = args.server;
    this.builders = args.builders;
    this.login_logout_button = $(args.login_logout_button);
    this.auth_status = $(args.auth_status);
    this.authenticated = false;
    this.ui_ready = false;
    this.oauth_window = null;
    this.method_metadata = {
      google_oauth2: {
        icon: 'fab fa-google',
        text: 'Google'
      },
      twitter: {
        icon: 'fab fa-twitter',
        text: 'Twitter'
      },
      discord: {
        icon: 'fab fa-discord',
        text: 'Discord'
      }
    };
    this.squad_display_mode = 'all';
    this.show_archived = false;
    this.collection_save_timer = null;
    this.collection_reset_timer = null;
    this.setupHandlers();
    this.setupUI();
    // Check initial authentication status
    this.authenticate(() => {
      this.auth_status.hide();
      return this.login_logout_button.removeClass('d-none');
    });
    ref = this.builders;
    // Finally, hook up the builders
    for (j = 0, len = ref.length; j < len; j++) {
      builder = ref[j];
      builder.setBackend(this);
    }
    this.updateAuthenticationVisibility();
  }

  updateAuthenticationVisibility() {
    if (this.authenticated) {
      $('.show-authenticated').show();
      return $('.hide-authenticated').hide();
    } else {
      $('.show-authenticated').hide();
      return $('.hide-authenticated').show();
    }
  }

  save(serialized, id = null, name, faction, additional_data = {}, cb) {
    var post_args, post_url;
    if (serialized === "") {
      return cb({
        id: null,
        success: false,
        error: "You cannot save an empty squad"
      });
    } else if ($.trim(name) === "") {
      return cb({
        id: null,
        success: false,
        error: "Squad name cannot be empty"
      });
    } else if ((faction == null) || faction === "") {
      throw "Faction unspecified to save()";
    } else {
      post_args = {
        name: $.trim(name),
        faction: $.trim(faction),
        serialized: serialized,
        additional_data: additional_data
      };
      if (id != null) {
        post_url = `${this.server}/squads/${id}`;
      } else {
        post_url = `${this.server}/squads/new`;
        post_args['_method'] = 'put';
      }
      return $.post(post_url, post_args, (data, textStatus, jqXHR) => {
        return cb({
          id: data.id,
          success: data.success,
          error: data.error
        });
      });
    }
  }

  delete(id, cb) {
    var post_args;
    post_args = {
      '_method': 'delete'
    };
    return $.post(`${this.server}/squads/${id}`, post_args, (data, textStatus, jqXHR) => {
      return cb({
        success: data.success,
        error: data.error
      });
    });
  }

  archive(data, faction, cb) {
    data.additional_data["archived"] = true;
    return this.save(data.serialized, data.id, data.name, faction, data.additional_data, cb);
  }

  list(builder) {
    var list_ul, loading_pane, tag_list, url;
    // TODO: Pagination
    this.squad_list_modal.find('.modal-header .squad-list-header-placeholder').text(exportObj.translate('ui', "yourXYsquads", builder.faction));
    list_ul = $(this.squad_list_modal.find('ul.squad-list'));
    list_ul.text('');
    list_ul.hide();
    loading_pane = $(this.squad_list_modal.find('p.squad-list-loading'));
    loading_pane.show();
    this.show_all_squads_button.click();
    this.squad_list_modal.modal('show');
    // This counter keeps tracked of the number of squads marked to be deleted (to hide the delete-selected button if none is selected)
    this.number_of_selected_squads_to_be_deleted = 0;
    //setup tag list
    tag_list = [];
    url = `${this.server}/squads/list`;
    return $.get(url, (data, textStatus, jqXHR) => {
      var hasNotArchivedSquads, isxwa, j, l, len, len1, len2, li, m, ref, ref1, ref2, ref3, ref4, ref5, ref6, squad, tag, tag_array, tag_button, tag_entry, tagclean;
      hasNotArchivedSquads = false;
      ref = data[builder.faction];
      for (j = 0, len = ref.length; j < len; j++) {
        squad = ref[j];
        li = $(document.createElement('LI'));
        li.addClass('squad-summary');
        li.data('squad', squad);
        li.data('builder', builder);
        li.data('selectedForDeletion', false);
        list_ul.append(li);
        if ((((ref1 = squad.additional_data) != null ? ref1.tag : void 0) != null) && (((ref2 = squad.additional_data) != null ? ref2.tag : void 0) !== "") && (tag_list.indexOf(squad.additional_data.tag) === -1)) {
          tag_array = (ref3 = squad.additional_data) != null ? ref3.tag.split(",") : void 0;
          for (l = 0, len1 = tag_array.length; l < len1; l++) {
            tag_entry = tag_array[l];
            tag_list.push(tag_entry);
          }
        }
        if (((ref4 = squad.additional_data) != null ? ref4.archived : void 0) != null) {
          li.hide();
        } else {
          hasNotArchivedSquads = true;
        }
        if (squad.serialized.search(/v\d+Zb/) !== -1) {
          isxwa = ` <i class="xwing-miniatures-font xwing-miniatures-font-point"></i>`;
        } else {
          isxwa = "";
        }
        li.append($.trim(`<div class="row">
    <div class="col-md-9">
        <h4>${squad.name}${isxwa}</h4>
    </div>
    <div class="col-md-3">
        <h5>${(ref5 = squad.additional_data) != null ? ref5.points : void 0} ${exportObj.translate('ui', "Points")}</h5>
    </div>
</div>
<div class="row squad-description">
    <div class="col-md-9">
        ${(ref6 = squad.additional_data) != null ? ref6.description : void 0}
    </div>
    <div class="squad-buttons col-md-3">
        <button class="btn btn-modal convert-squad"><i class="xwing-miniatures-font xwing-miniatures-font-first-player-1"></i></button>
        &nbsp;
        <button class="btn btn-modal load-squad"><i class="fa fa-download"></i></button>
        &nbsp;
        <button class="btn btn-danger delete-squad"><i class="fa fa-times"></i></button>
    </div>
</div>
<div class="row squad-convert-confirm">
    <div class="col-md-9 translated" defaultText="Convert to Extended?">
    </div>
    <div class="squad-buttons col-md-3">
        <button class="btn btn-danger confirm-convert-squad translated" defaultText="Convert"></button>
        &nbsp;
        <button class="btn btn-modal cancel-convert-squad translated" defaultText="Cancel"></button>
    </div>
</div>
<div class="row squad-delete-confirm">
    <div class="col-md-6">
        ${exportObj.translate('ui', 'reallyDeleteSquadXY', `<em>${squad.name}</em>`)}
    </div>
    <div class="col-md-6 btn-group">
        <button class="btn btn-danger confirm-delete-squad translated" defaultText="Delete"></button>
        <button class="btn confirm-archive-squad translated" defaultText="Archive"></button>
        <button class="btn btn-modal cancel-delete-squad translated" defaultText="Unselect"></button>
    </div>
</div>`));
        li.find('.squad-convert-confirm').hide();
        li.find('.squad-delete-confirm').hide();
        if (squad.serialized.search(/v\d+Zh/) === -1) {
          li.find('button.convert-squad').hide();
        }
        li.find('button.convert-squad').click((e) => {
          var button;
          e.preventDefault();
          button = $(e.target);
          li = button.closest('li');
          builder = li.data('builder');
          li.data('selectedToConvert', true);
          return ((li) => {
            return li.find('.squad-description').fadeOut('fast', function() {
              return li.find('.squad-convert-confirm').fadeIn('fast');
            });
          })(li);
        });
        li.find('button.cancel-convert-squad').click((e) => {
          var button;
          e.preventDefault();
          button = $(e.target);
          li = button.closest('li');
          builder = li.data('builder');
          li.data('selectedToConvert', false);
          return ((li) => {
            return li.find('.squad-convert-confirm').fadeOut('fast', function() {
              return li.find('.squad-description').fadeIn('fast');
            });
          })(li);
        });
        li.find('button.confirm-convert-squad').click((e) => {
          var button, new_serialized;
          e.preventDefault();
          button = $(e.target);
          li = button.closest('li');
          builder = li.data('builder');
          li.find('.cancel-convert-squad').fadeOut('fast');
          li.find('.confirm-convert-squad').addClass('disabled');
          li.find('.confirm-convert-squad').text('Converting...');
          new_serialized = li.data('squad').serialized.replace('Zh', 'Zs');
          return this.save(new_serialized, li.data('squad').id, li.data('squad').name, li.data('builder').faction, li.data('squad').additional_data, (results) => {
            if (results.success) {
              li.data('squad').serialized = new_serialized;
              return li.find('.squad-convert-confirm').fadeOut('fast', function() {
                li.find('.squad-description').fadeIn('fast');
                return li.find('button.convert-squad').fadeOut('fast');
              });
            } else {
              return li.html($.trim(`Error converting ${li.data('squad').name}: <em>${results.error}</em>`));
            }
          });
        });
        li.find('button.load-squad').click((e) => {
          var button;
          e.preventDefault();
          button = $(e.target);
          li = button.closest('li');
          builder = li.data('builder');
          this.squad_list_modal.modal('hide');
          if (builder.current_squad.dirty) {
            return this.warnUnsaved(builder, function() {
              return builder.container.trigger('xwing-backend:squadLoadRequested', li.data('squad'));
            });
          } else {
            return builder.container.trigger('xwing-backend:squadLoadRequested', li.data('squad'));
          }
        });
        li.find('button.delete-squad').click((e) => {
          var button;
          e.preventDefault();
          button = $(e.target);
          li = button.closest('li');
          builder = li.data('builder');
          li.data('selectedForDeletion', true);
          ((li) => {
            li.find('.squad-description').fadeOut('fast', function() {
              return li.find('.squad-delete-confirm').fadeIn('fast');
            });
            // show delete multiple section if not yet shown
            if (!this.number_of_selected_squads_to_be_deleted) {
              return this.squad_list_modal.find('div.delete-multiple-squads').show();
            }
          })(li);
          // increment counter
          return this.number_of_selected_squads_to_be_deleted += 1;
        });
        li.find('button.cancel-delete-squad').click((e) => {
          var button;
          e.preventDefault();
          button = $(e.target);
          li = button.closest('li');
          builder = li.data('builder');
          li.data('selectedForDeletion', false);
          // decrement counter
          this.number_of_selected_squads_to_be_deleted -= 1;
          return ((li) => {
            li.find('.squad-delete-confirm').fadeOut('fast', function() {
              return li.find('.squad-description').fadeIn('fast');
            });
            // hide delete multiple section if this was the last selected squad
            if (!this.number_of_selected_squads_to_be_deleted) {
              return this.squad_list_modal.find('div.delete-multiple-squads').hide();
            }
          })(li);
        });
        li.find('button.confirm-delete-squad').click((e) => {
          var button;
          e.preventDefault();
          button = $(e.target);
          li = button.closest('li');
          builder = li.data('builder');
          li.find('.cancel-delete-squad').fadeOut('fast');
          li.find('.confirm-delete-squad').addClass('disabled');
          li.find('.confirm-delete-squad').text('Deleting...');
          return this.delete(li.data('squad').id, (results) => {
            if (results.success) {
              li.slideUp('fast', function() {
                return $(li).remove();
              });
              // decrement counter
              this.number_of_selected_squads_to_be_deleted -= 1;
              // hide delete multiple section if this was the last selected squad
              if (!this.number_of_selected_squads_to_be_deleted) {
                return this.squad_list_modal.find('div.delete-multiple-squads').hide();
              }
            } else {
              return li.html($.trim(`Error deleting ${li.data('squad').name}: <em>${results.error}</em>`));
            }
          });
        });
        li.find('button.confirm-archive-squad').click((e) => {
          var button;
          e.preventDefault();
          button = $(e.target);
          li = button.closest('li');
          builder = li.data('builder');
          li.find('.confirm-delete-squad').addClass('disabled');
          li.find('.confirm-delete-squad').text(exportObj.translate('ui', 'Archiving...'));
          return this.archive(li.data('squad'), li.data('builder').faction, (results) => {
            if (results.success) {
              li.slideUp('fast', function() {
                $(li).hide();
                $(li).find('.confirm-delete-squad').removeClass('disabled');
                $(li).find('.confirm-delete-squad').text(exportObj.translate('ui', 'Delete'));
                $(li).data('selectedForDeletion', false);
                return $(li).find('.squad-delete-confirm').fadeOut('fast', function() {
                  return $(li).find('.squad-description').fadeIn('fast');
                });
              });
              // decrement counter
              this.number_of_selected_squads_to_be_deleted -= 1;
              // hide delete multiple section if this was the last selected squad
              if (!this.number_of_selected_squads_to_be_deleted) {
                return this.squad_list_modal.find('div.delete-multiple-squads').hide();
              }
            } else {
              return li.html($.trim(`Error archiving ${li.data('squad').name}: <em>${results.error}</em>`));
            }
          });
        });
      }
      if (!hasNotArchivedSquads) {
        list_ul.append($.trim(`<li class="translated" defaultText="No saved squads"></li>`));
      }
      
      //setup Tags
      this.squad_list_tags.empty();
      for (m = 0, len2 = tag_list.length; m < len2; m++) {
        tag = tag_list[m];
        tagclean = tag.toLowerCase().replace(/[^a-z0-9]/g, '').replace(/\s+/g, '-');
        this.squad_list_tags.append($.trim(`<button class="btn ${tagclean}">${tag}</button>`));
        tag_button = $(this.squad_list_tags.find(`.${tagclean}`));
        tag_button.click((e) => {
          var button, buttontag;
          button = $(e.target);
          buttontag = button.attr('class').replace('btn ', '').replace('btn-inverse ', '');
          this.squad_list_modal.find('.squad-display-mode .btn').removeClass('btn-inverse');
          this.squad_list_tags.find('.btn').removeClass('btn-inverse');
          button.addClass('btn-inverse');
          return this.squad_list_modal.find('.squad-list li').each(function(idx, elem) {
            var found_tag, len3, o;
            if ($(elem).data().squad.additional_data.tag != null) {
              tag_array = $(elem).data().squad.additional_data.tag.split(",");
              found_tag = false;
              for (o = 0, len3 = tag_array.length; o < len3; o++) {
                tag = tag_array[o];
                if (buttontag === tag.toLowerCase().replace(/[^a-z0-9]/g, '').replace(/\s+/g, '-')) {
                  found_tag = true;
                }
              }
              if (found_tag) {
                return $(elem).show();
              } else {
                return $(elem).hide();
              }
            } else {
              return $(elem).hide();
            }
          });
        });
      }
      // some of the created html needs translation (e.g. buttons). Do that now.
      exportObj.translateUIElements(list_ul);
      loading_pane.fadeOut('fast');
      return list_ul.fadeIn('fast');
    });
  }

  authenticate(cb = $.noop) {
    var old_auth_state;
    $(this.auth_status.find('.payload')).text(exportObj.translate('ui', 'Checking auth status...'));
    this.auth_status.show();
    old_auth_state = this.authenticated;
    return $.ajax({
      url: `${this.server}/ping`,
      success: (data) => {
        if (data != null ? data.success : void 0) {
          this.authenticated = true;
        } else {
          this.authenticated = false;
        }
        return this.maybeAuthenticationChanged(old_auth_state, cb);
      },
      error: (jqXHR, textStatus, errorThrown) => {
        this.authenticated = false;
        return this.maybeAuthenticationChanged(old_auth_state, cb);
      }
    });
  }

  maybeAuthenticationChanged(old_auth_state, cb) {
    if (old_auth_state !== this.authenticated) {
      $(window).trigger('xwing-backend:authenticationChanged', [this.authenticated, this]);
    }
    this.oauth_window = null;
    this.auth_status.hide();
    cb(this.authenticated);
    return this.authenticated;
  }

  login() {
    // Display login dialog.
    if (this.ui_ready) {
      return this.login_modal.modal('show');
    }
  }

  logout(cb = $.noop) {
    $(this.auth_status.find('.payload')).text(exportObj.translate('ui', 'Logging out...'));
    this.auth_status.show();
    return $.get(`${this.server}/auth/logout`, (data, textStatus, jqXHR) => {
      this.authenticated = false;
      $(window).trigger('xwing-backend:authenticationChanged', [this.authenticated, this]);
      this.auth_status.hide();
      return cb();
    });
  }

  showSaveAsModal(builder) {
    this.save_as_modal.data('builder', builder);
    this.save_as_input.val(builder.current_squad.name);
    this.save_as_save_button.addClass('disabled');
    this.nameCheck();
    return this.save_as_modal.modal('show');
  }

  showDeleteModal(builder) {
    this.delete_modal.data('builder', builder);
    this.delete_name_container.text(builder.current_squad.name);
    return this.delete_modal.modal('show');
  }

  nameCheck() {
    var name;
    window.clearInterval(this.save_as_modal.data('timer'));
    // trivial check
    name = $.trim(this.save_as_input.val());
    if (name.length === 0) {
      this.name_availability_container.text('');
      return this.name_availability_container.append($.trim(`<i class="fa fa-thumbs-down"></i> ${exportObj.translate('ui', "name required")}`));
    } else {
      return $.post(`${this.server}/squads/namecheck`, {
        name: name
      }, (data) => {
        this.name_availability_container.text('');
        if (data.available) {
          this.name_availability_container.append($.trim(`<i class="fa fa-thumbs-up"></i> ${exportObj.translate('ui', "Name is available")}`));
          return this.save_as_save_button.removeClass('disabled');
        } else {
          this.name_availability_container.append($.trim(`<i class="fa fa-thumbs-down"></i> ${exportObj.translate('ui', "Name in use")}`));
          return this.save_as_save_button.addClass('disabled');
        }
      });
    }
  }

  warnUnsaved(builder, action) {
    this.unsaved_modal.data('builder', builder);
    this.unsaved_modal.data('callback', action);
    return this.unsaved_modal.modal('show');
  }

  setupUI() {
    var oauth_explanation;
    this.auth_status.addClass('disabled');
    this.auth_status.click((e) => {
      return false;
    });
    this.login_modal = $(document.createElement('DIV'));
    this.login_modal.addClass('modal fade d-print-none');
    this.login_modal.tabindex = "-1";
    this.login_modal.role = "dialog";
    $(document.body).append(this.login_modal);
    this.login_modal.append($.trim(`<div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="translated" defaultText="Log in with OAuth"></h3>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        </div>
        <div class="modal-body">
            <p>
                <span class="translated" defaultText="select OAuth provider"></span>
                <a class="login-help translated" href="#" defaultText="What's this?"></a>
            </p>
            <div class="well well-small oauth-explanation">
                <span class="translated" defaultText="OAuth explanation"></span>
                <button class="btn btn-modal translated" defaultText="Got it!"></button>
            </div>
            <ul class="login-providers inline"></ul>
            <p class="translated" defaultText="Continue to OAuth provider"></p>
            <p class="translated" defaultText="iOS requires cross-site control"></p>
            <p class="login-in-progress">
                <em class="translated" defaultText="login in progress"></em>
            </p>
        </div>
    </div>
</div>`));
    oauth_explanation = $(this.login_modal.find('.oauth-explanation'));
    oauth_explanation.hide();
    this.login_modal.find('.login-in-progress').hide();
    this.login_modal.find('a.login-help').click((e) => {
      e.preventDefault();
      if (!oauth_explanation.is(':visible')) {
        return oauth_explanation.slideDown('fast');
      }
    });
    oauth_explanation.find('button').click((e) => {
      e.preventDefault();
      return oauth_explanation.slideUp('fast');
    });
    $.get(`${this.server}/methods`, (data, textStatus, jqXHR) => {
      var a, j, len, li, method, methods_ul, ref;
      methods_ul = $(this.login_modal.find('ul.login-providers'));
      ref = data.methods;
      for (j = 0, len = ref.length; j < len; j++) {
        method = ref[j];
        a = $(document.createElement('A'));
        a.addClass('btn btn-modal');
        a.data('url', `${this.server}/auth/${method}`);
        a.append(`<i class="${this.method_metadata[method].icon}"></i>&nbsp;${this.method_metadata[method].text}`);
        a.click((e) => {
          e.preventDefault();
          methods_ul.slideUp('fast');
          this.login_modal.find('.login-in-progress').slideDown('fast');
          return this.oauth_window = window.open($(e.target).data('url'), "xwing_login");
        });
        li = $(document.createElement('LI'));
        li.append(a);
        methods_ul.append(li);
      }
      return this.ui_ready = true;
    });
    // this is dynamically created UI, so we need to translate it after creation
    exportObj.translateUIElements(this.login_modal);
    this.reload_done_modal = $(document.createElement('DIV'));
    this.reload_done_modal.addClass('modal fade d-print-none');
    this.reload_done_modal.tabindex = "-1";
    this.reload_done_modal.role = "dialog";
    $(document.body).append(this.reload_done_modal);
    this.reload_done_modal.append($.trim(`<div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Reload Done</h3>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        </div>
        <div class="modal-body">
            <p class="translated" defaultText="Squads reloaded"></p>
        </div>
        <div class="modal-footer">
            <button class="btn btn-modal btn-primary translated" aria-hidden="true" data-dismiss="modal" defaultText="Well done!"></button>
        </div>
    </div>
</div>`));
    // this is dynamically created UI, so we need to translate it after creation
    exportObj.translateUIElements(this.reload_done_modal);
    this.squad_list_modal = $(document.createElement('DIV'));
    this.squad_list_modal.addClass('modal fade d-print-none squad-list');
    this.squad_list_modal.tabindex = "-1";
    this.squad_list_modal.role = "dialog";
    $(document.body).append(this.squad_list_modal);
    this.squad_list_modal.append($.trim(`<div class="modal-dialog modal-lg modal-dialog-scrollable modal-dialog-centered" role="document">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="squad-list-header-placeholder d-none d-lg-block"></h3>
            <h4 class="squad-list-header-placeholder d-lg-none"></h4>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        </div>
        <div class="modal-body">
            <ul class="squad-list"></ul>
            <p class="pagination-centered squad-list-loading">
                <i class="fa fa-spinner fa-spin fa-3x"></i>
                <br />
                <span class="translated" defaultText="Fetching squads..."></span>
            </p>
        </div>
        <div class="modal-footer">
            <div class="btn-group delete-multiple-squads full-row">
                <button class="btn btn-modal select-all translated" defaultText="Select All"></button>
                <button class="btn btn-modal archive-selected translated" defaultText="Archive Selected"></button>
                <button class="btn btn-modal btn-danger delete-selected translated" defaultText="Delete Selected"></button>
            </div>
            <div class="btn-group squad-display-mode full-row">
                <button class="btn btn-modal btn-inverse show-all-squads translated" defaultText="All"></button>
                <button class="btn btn-modal show-standard-squads"><span class="d-none d-lg-block translated" defaultText="Standard"></span><span class="d-lg-none"><i class="xwing-miniatures-font xwing-miniatures-font-first-player-1"></i></span></button>
                <button class="btn btn-modal show-extended-squads"><span class="d-none d-lg-block translated" defaultText="Extended"></span><span class="d-lg-none translated" defaultText="Ext"></span></button>
                <button class="btn btn-modal show-xwa-squads"><span class="d-none d-lg-block translated" defaultText="XWA"></span><span class="d-lg-none"><i class="xwing-miniatures-font xwing-miniatures-font-point" title="Energy"></i></span></button>
                <button class="btn btn-modal show-quickbuild-squads"><span class="d-none d-lg-block translated" defaultText="Quickbuild"></span><span class="d-lg-none translated" defaultText="QB"></span></button>
                <button class="btn btn-modal show-epic-squads"><span class="d-none d-lg-block translated" defaultText="Epic"></span><span class="d-lg-none" ><i class="xwing-miniatures-font xwing-miniatures-font-energy" title="Energy"></i></span></button>
                <button class="btn btn-modal show-archived-squads"><span class="d-none d-lg-block translated" defaultText="Archived"></span><span class="d-lg-none translated" defaultText="Arc"></span></button>
                <button class="btn btn-modal reload-all" title="Recalculate Points"><span><i class="xwing-miniatures-font xwing-miniatures-font-calculate" title="Calculate"></i></span></button>
            </div>
            <div class="btn-group tags-display full-row">
            </div>
        </div>
    </div>
</div>`));
    this.squad_list_modal.find('ul.squad-list').hide();
    this.squad_list_tags = $(this.squad_list_modal.find('div.tags-display'));
    
    // The delete multiple section only appeares, when somebody hits the delete button of one squad. 
    this.squad_list_modal.find('div.delete-multiple-squads').hide();
    
    // this is dynamically created UI, so we need to translate it after creation
    exportObj.translateUIElements(this.squad_list_modal);
    this.delete_selected_button = $(this.squad_list_modal.find('button.delete-selected'));
    this.delete_selected_button.click((e) => {
      var j, len, li, ref, results1, ul;
      ul = this.squad_list_modal.find('ul.squad-list');
      ref = ul.find('li');
      results1 = [];
      for (j = 0, len = ref.length; j < len; j++) {
        li = ref[j];
        li = $(li);
        if (li.data('selectedForDeletion')) {
          results1.push(((li) => {
            li.find('.cancel-delete-squad').fadeOut('fast');
            li.find('.confirm-delete-squad').addClass('disabled');
            li.find('.confirm-delete-squad').text(exportObj.translate('ui', 'Deleting...'));
            return this.delete(li.data('squad').id, (results) => {
              if (results.success) {
                li.slideUp('fast', function() {
                  return $(li).remove();
                });
                // decrement counter
                this.number_of_selected_squads_to_be_deleted -= 1;
                // hide delete multiple section if this was the last selected squad
                if (!this.number_of_selected_squads_to_be_deleted) {
                  return this.squad_list_modal.find('div.delete-multiple-squads').hide();
                }
              } else {
                return li.html($.trim(`Error deleting ${li.data('squad').name}: <em>${results.error}</em>`));
              }
            });
          })(li));
        } else {
          results1.push(void 0);
        }
      }
      return results1;
    });
    this.archive_selected_button = $(this.squad_list_modal.find('button.archive-selected'));
    this.archive_selected_button.click((e) => {
      var j, len, li, ref, results1, ul;
      ul = this.squad_list_modal.find('ul.squad-list');
      ref = ul.find('li');
      results1 = [];
      for (j = 0, len = ref.length; j < len; j++) {
        li = ref[j];
        li = $(li);
        if (li.data('selectedForDeletion')) {
          results1.push(((li) => {
            li.find('.confirm-delete-squad').addClass('disabled');
            li.find('.confirm-delete-squad').text(exportObj.translate('ui', 'Archiving...'));
            return this.archive(li.data('squad'), li.data('builder').faction, (results) => {
              if (results.success) {
                li.slideUp('fast', function() {
                  $(li).hide();
                  $(li).find('.confirm-delete-squad').removeClass('disabled');
                  $(li).find('.confirm-delete-squad').text(exportObj.translate('ui', 'Delete'));
                  $(li).data('selectedForDeletion', false);
                  return $(li).find('.squad-delete-confirm').fadeOut('fast', function() {
                    return $(li).find('.squad-description').fadeIn('fast');
                  });
                });
                // decrement counter
                this.number_of_selected_squads_to_be_deleted -= 1;
                // hide delete multiple section if this was the last selected squad
                if (!this.number_of_selected_squads_to_be_deleted) {
                  return this.squad_list_modal.find('div.delete-multiple-squads').hide();
                }
              } else {
                return li.html($.trim(`Error archiving ${li.data('squad').name}: <em>${results.error}</em>`));
              }
            });
          })(li));
        } else {
          results1.push(void 0);
        }
      }
      return results1;
    });
    this.squad_list_modal.find('button.reload-all').click((e) => {
      var builder, j, len, li, ref, squadDataStack, squadProcessingStack, ul;
      ul = this.squad_list_modal.find('ul.squad-list');
      squadProcessingStack = [
        () => {
          return this.reload_done_modal.modal('show');
        }
      ];
      squadDataStack = [];
      ref = ul.find('li');
      for (j = 0, len = ref.length; j < len; j++) {
        li = ref[j];
        li = $(li);
        squadDataStack.push(li.data('squad'));
        builder = li.data('builder');
        squadProcessingStack.push(() => {
          var sqd;
          sqd = squadDataStack.pop();
          // console.log("loading " + sqd.name)
          return builder.container.trigger('xwing-backend:squadLoadRequested', [
            sqd,
            () => {
              var additional_data;
              additional_data = {
                points: builder.total_points,
                description: builder.describeSquad(),
                cards: builder.listCards(),
                notes: builder.notes.val().substr(0,
            1024),
                obstacles: builder.getObstacles(),
                tag: builder.tag.val().substr(0,
            1024)
              };
              // console.log("saving " + builder.current_squad.name)
              return this.save(builder.serialize(),
            builder.current_squad.id,
            builder.current_squad.name,
            builder.faction,
            additional_data,
            squadProcessingStack.pop());
            }
          ]);
        });
      }
      this.squad_list_modal.modal('hide');
      if (builder.current_squad.dirty) {
        return this.warnUnsaved(builder, squadProcessingStack.pop());
      } else {
        return squadProcessingStack.pop()();
      }
    });
    this.select_all_button = $(this.squad_list_modal.find('button.select-all'));
    this.select_all_button.click((e) => {
      var j, len, li, ref, results1, ul;
      ul = this.squad_list_modal.find('ul.squad-list');
      ref = ul.find('li');
      results1 = [];
      for (j = 0, len = ref.length; j < len; j++) {
        li = ref[j];
        li = $(li);
        if (!li.data('selectedForDeletion')) {
          li.data('selectedForDeletion', true);
          ((li) => {
            return li.find('.squad-description').fadeOut('fast', function() {
              return li.find('.squad-delete-confirm').fadeIn('fast');
            });
          })(li);
          results1.push(this.number_of_selected_squads_to_be_deleted += 1);
        } else {
          results1.push(void 0);
        }
      }
      return results1;
    });
    this.show_all_squads_button = $(this.squad_list_modal.find('.show-all-squads'));
    this.show_all_squads_button.click((e) => {
      if (this.squad_display_mode !== 'all') {
        this.squad_display_mode = 'all';
        this.squad_list_modal.find('.squad-display-mode .btn').removeClass('btn-inverse');
        this.squad_list_tags.find('.btn').removeClass('btn-inverse');
        this.show_all_squads_button.addClass('btn-inverse');
        return this.squad_list_modal.find('.squad-list li').show();
      }
    });
    this.show_extended_squads_button = $(this.squad_list_modal.find('.show-extended-squads'));
    this.show_extended_squads_button.click((e) => {
      if (this.squad_display_mode !== 'extended') {
        this.squad_display_mode = 'extended';
        this.squad_list_modal.find('.squad-display-mode .btn').removeClass('btn-inverse');
        this.squad_list_tags.find('.btn').removeClass('btn-inverse');
        this.show_extended_squads_button.addClass('btn-inverse');
        return this.squad_list_modal.find('.squad-list li').each(function(idx, elem) {
          return $(elem).toggle($(elem).data().squad.serialized.search(/v\d+Zs/) !== -1);
        });
      }
    });
    this.show_epic_squads_button = $(this.squad_list_modal.find('.show-epic-squads'));
    this.show_epic_squads_button.click((e) => {
      if (this.squad_display_mode !== 'epic') {
        this.squad_display_mode = 'epic';
        this.squad_list_modal.find('.squad-display-mode .btn').removeClass('btn-inverse');
        this.squad_list_tags.find('.btn').removeClass('btn-inverse');
        this.show_epic_squads_button.addClass('btn-inverse');
        return this.squad_list_modal.find('.squad-list li').each(function(idx, elem) {
          return $(elem).toggle($(elem).data().squad.serialized.search(/v\d+Ze/) !== -1);
        });
      }
    });
    this.show_standard_squads_button = $(this.squad_list_modal.find('.show-standard-squads'));
    this.show_standard_squads_button.click((e) => {
      if (this.squad_display_mode !== 'standard') {
        this.squad_display_mode = 'standard';
        this.squad_list_modal.find('.squad-display-mode .btn').removeClass('btn-inverse');
        this.squad_list_tags.find('.btn').removeClass('btn-inverse');
        this.show_standard_squads_button.addClass('btn-inverse');
        return this.squad_list_modal.find('.squad-list li').each(function(idx, elem) {
          return $(elem).toggle($(elem).data().squad.serialized.search(/v\d+Zh/) !== -1);
        });
      }
    });
    this.show_xwa_squads_button = $(this.squad_list_modal.find('.show-xwa-squads'));
    this.show_xwa_squads_button.click((e) => {
      if (this.squad_display_mode !== 'xwa') {
        this.squad_display_mode = 'xwa';
        this.squad_list_modal.find('.squad-display-mode .btn').removeClass('btn-inverse');
        this.squad_list_tags.find('.btn').removeClass('btn-inverse');
        this.show_xwa_squads_button.addClass('btn-inverse');
        return this.squad_list_modal.find('.squad-list li').each(function(idx, elem) {
          return $(elem).toggle($(elem).data().squad.serialized.search(/v\d+Zb/) !== -1);
        });
      }
    });
    this.show_quickbuild_squads_button = $(this.squad_list_modal.find('.show-quickbuild-squads'));
    this.show_quickbuild_squads_button.click((e) => {
      if (this.squad_display_mode !== 'quickbuild') {
        this.squad_display_mode = 'quickbuild';
        this.squad_list_modal.find('.squad-display-mode .btn').removeClass('btn-inverse');
        this.squad_list_tags.find('.btn').removeClass('btn-inverse');
        this.show_quickbuild_squads_button.addClass('btn-inverse');
        return this.squad_list_modal.find('.squad-list li').each(function(idx, elem) {
          return $(elem).toggle($(elem).data().squad.serialized.search(/v\d+Zq/) !== -1);
        });
      }
    });
    this.show_archived_squads_button = $(this.squad_list_modal.find('.show-archived-squads'));
    this.show_archived_squads_button.click((e) => {
      this.show_archived = !this.show_archived;
      if (this.show_archived) {
        this.show_archived_squads_button.addClass('btn-inverse');
      } else {
        this.show_archived_squads_button.removeClass('btn-inverse');
      }
      this.squad_list_tags.find('.btn').removeClass('btn-inverse');
      return this.squad_list_modal.find('.squad-list li').each((idx, elem) => {
        return $(elem).toggle(($(elem).data().squad.additional_data.archived != null) === this.show_archived);
      });
    });
    this.save_as_modal = $(document.createElement('DIV'));
    this.save_as_modal.addClass('modal fade d-print-none');
    this.save_as_modal.tabindex = "-1";
    this.save_as_modal.role = "dialog";
    $(document.body).append(this.save_as_modal);
    this.save_as_modal.append($.trim(`<div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="translated" defaultText="Save Squad As..."></h3>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        </div>
        <div class="modal-body">
            <label for="xw-be-squad-save-as">
                <span class="translated" defaultText="New Squad Name"></span>
                <input id="xw-be-squad-save-as"></input>
            </label>
            <span class="name-availability"></span>
        </div>
        <div class="modal-footer">
            <button class="btn btn-primary save translated" aria-hidden="true" defaultText="Save"></button>
        </div>
    </div>
</div>`));
    this.save_as_modal.on('shown', () => {
      // Because Firefox handles this badly
      return window.setTimeout(() => {
        this.save_as_input.focus();
        return this.save_as_input.select();
      }, 100);
    });
    this.save_as_save_button = this.save_as_modal.find('button.save');
    this.save_as_save_button.click((e) => {
      var additional_data, builder, new_name, timer;
      e.preventDefault();
      if (!this.save_as_save_button.hasClass('disabled')) {
        timer = this.save_as_modal.data('timer');
        if (timer != null) {
          window.clearInterval(timer);
        }
        this.save_as_modal.modal('hide');
        builder = this.save_as_modal.data('builder');
        additional_data = {
          points: builder.total_points,
          description: builder.describeSquad(),
          cards: builder.listCards(),
          notes: builder.getNotes(),
          obstacles: builder.getObstacles(),
          tag: builder.getTag()
        };
        builder.backend_save_list_as_button.addClass('disabled');
        builder.backend_status.html($.trim(`<i class="fa fa-sync fa-spin"></i>&nbsp;${exportObj.translate('ui', 'Saving squad...')}`));
        builder.backend_status.show();
        new_name = $.trim(this.save_as_input.val());
        return this.save(builder.serialize(), null, new_name, builder.faction, additional_data, (results) => {
          if (results.success) {
            builder.current_squad.id = results.id;
            builder.current_squad.name = new_name;
            builder.current_squad.dirty = false;
            builder.container.trigger('xwing-backend:squadNameChanged');
            builder.container.trigger('xwing-backend:squadDirtinessChanged');
            builder.backend_status.html($.trim(`<i class="fa fa-check"></i>&nbsp;${exportObj.translate('ui', 'New squad saved successfully.')}`));
          } else {
            builder.backend_status.html($.trim(`<i class="fa fa-exclamation-circle"></i>&nbsp;${results.error}`));
          }
          return builder.backend_save_list_as_button.removeClass('disabled');
        });
      }
    });
    this.save_as_input = $(this.save_as_modal.find('input'));
    this.save_as_input.keypress((e) => {
      var timer;
      if (e.which === 13) {
        this.save_as_save_button.click();
        return false;
      } else {
        this.name_availability_container.text('');
        this.name_availability_container.append($.trim(`<i class="fa fa-spin fa-spinner"></i> ${exportObj.translate('ui', 'Checking name availability...')}`));
        timer = this.save_as_modal.data('timer');
        if (timer != null) {
          window.clearInterval(timer);
        }
        return this.save_as_modal.data('timer', window.setInterval(this.nameCheck, 500));
      }
    });
    this.name_availability_container = $(this.save_as_modal.find('.name-availability'));
    // this is dynamically created UI, so we need to translate it after creation
    exportObj.translateUIElements(this.squad_list_modal);
    this.delete_modal = $(document.createElement('DIV'));
    this.delete_modal.addClass('modal fade d-print-none');
    this.delete_modal.tabindex = "-1";
    this.delete_modal.role = "dialog";
    $(document.body).append(this.delete_modal);
    this.delete_modal.append($.trim(`<div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
        <div class="modal-header">
            <h3><span class="translated" defaultText="Really Delete"></span> <span class="squad-name-placeholder"></span>?</h3>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        </div>
        <div class="modal-body">
            <p class="translated" defaultText="Sure to delete?"></p>
        </div>
        <div class="modal-footer">
            <button class="btn btn-danger delete" aria-hidden="true"><span class="translated" defaultText="Yes, Delete"></span> <i class="squad-name-placeholder"></i></button>
            <button class="btn btn-modal translated" data-dismiss="modal" aria-hidden="true" defaultText="Never Mind"></button>
        </div>
    </div>
</div>`));
    this.delete_name_container = $(this.delete_modal.find('.squad-name-placeholder'));
    this.delete_button = $(this.delete_modal.find('button.delete'));
    this.delete_button.click((e) => {
      var builder;
      e.preventDefault();
      builder = this.delete_modal.data('builder');
      builder.backend_status.html($.trim(`<i class="fa fa-sync fa-spin"></i>&nbsp;${exportObj.translate('ui', "Deleting squad...")}`));
      builder.backend_status.show();
      builder.backend_delete_list_button.addClass('disabled');
      this.delete_modal.modal('hide');
      return this.delete(builder.current_squad.id, (results) => {
        if (results.success) {
          builder.resetCurrentSquad();
          builder.current_squad.dirty = true;
          builder.container.trigger('xwing-backend:squadDirtinessChanged');
          return builder.backend_status.html($.trim(`<i class="fa fa-check"></i>&nbsp;${exportObj.translate('ui', "Squad deleted.")}`));
        } else {
          builder.backend_status.html($.trim(`<i class="fa fa-exclamation-circle"></i>&nbsp;${results.error}`));
          // Failed, so offer chance to delete again
          return builder.backend_delete_list_button.removeClass('disabled');
        }
      });
    });
    // this is dynamically created UI, so we need to translate it after creation
    exportObj.translateUIElements(this.delete_modal);
    this.unsaved_modal = $(document.createElement('DIV'));
    this.unsaved_modal.addClass('modal fade d-print-none');
    this.unsaved_modal.tabindex = "-1";
    this.unsaved_modal.role = "dialog";
    $(document.body).append(this.unsaved_modal);
    this.unsaved_modal.append($.trim(`<div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="translated" defaultText="Unsaved Changes"></h3>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        </div>
        <div class="modal-body">
            <p class="translated" defaultText="Unsaved Changes Warning"></p>
        </div>
        <div class="modal-footer">
            <button class="btn btn-modal btn-primary translated" aria-hidden="true" data-dismiss="modal" defaultText="Go Back"></button>
            <button class="btn btn-danger discard translated" aria-hidden="true" defaultText="Discard Changes"></button>
        </div>
    </div>
</div>`));
    this.unsaved_discard_button = $(this.unsaved_modal.find('button.discard'));
    this.unsaved_discard_button.click((e) => {
      e.preventDefault();
      this.unsaved_modal.data('builder').current_squad.dirty = false;
      this.unsaved_modal.data('callback')();
      return this.unsaved_modal.modal('hide');
    });
    // this is dynamically created UI, so we need to translate it after creation
    return exportObj.translateUIElements(this.unsaved_modal);
  }

  setupHandlers() {
    $(window).on('xwing-backend:authenticationChanged', (e, authenticated, backend) => {
      this.updateAuthenticationVisibility();
      if (authenticated) {
        return this.loadCollection();
      }
    });
    this.login_logout_button.click((e) => {
      e.preventDefault();
      if (this.authenticated) {
        return this.logout();
      } else {
        return this.login();
      }
    });
    return $(window).on('message', (e) => {
      var ev, ref, ref1;
      ev = e.originalEvent;
      if (ev.origin === this.server) {
        switch ((ref = ev.data) != null ? ref.command : void 0) {
          case 'auth_successful':
            this.authenticate();
            this.login_modal.modal('hide');
            this.login_modal.find('.login-in-progress').hide();
            this.login_modal.find('ul.login-providers').show();
            return ev.source.close();
          default:
            return console.log(`Unexpected command ${(ref1 = ev.data) != null ? ref1.command : void 0}`);
        }
      } else {
        console.log(`Message received from unapproved origin ${ev.origin}`);
        return window.last_ev = e;
      }
    }).on('xwing-collection:changed', (e, collection) => {
      if (this.collection_save_timer != null) {
        clearTimeout(this.collection_save_timer);
      }
      return this.collection_save_timer = setTimeout(() => {
        return this.saveCollection(collection, function(res) {
          if (res) {
            return $(window).trigger('xwing-collection:saved', collection);
          }
        });
      }, 1000);
    }).on('xwing-collection:reset', (e, collection) => {
      if (this.collection_save_timer != null) {
        clearTimeout(this.collection_save_timer);
      }
      return this.collection_save_timer = setTimeout(() => {
        return this.resetCollection(collection, function(res) {
          if (res) {
            return $(window).trigger('xwing-collection:reset', collection);
          }
        });
      }, 1000);
    });
  }

  getSettings(cb = $.noop) {
    return $.get(`${this.server}/settings`).done((data, textStatus, jqXHR) => {
      return cb(data.settings);
    });
  }

  set(setting, value, cb = $.noop) {
    var post_args;
    post_args = {
      "_method": "PUT"
    };
    post_args[setting] = value;
    return $.post(`${this.server}/settings`, post_args).done((data, textStatus, jqXHR) => {
      return cb(data.set);
    });
  }

  deleteSetting(setting, cb = $.noop) {
    return $.post(`${this.server}/settings/${setting}`, {
      "_method": "DELETE"
    }).done((data, textStatus, jqXHR) => {
      return cb(data.deleted);
    });
  }

  getHeaders(cb = $.noop) {
    return $.get(`${this.server}/headers`).done((data, textStatus, jqXHR) => {
      return cb(data.headers);
    });
  }

  async getLanguagePreference(settings, cb = $.noop) {
    // check if user provided a language preference. If yes, this will override the browser preference queried in translate.coffee
    if ((settings != null ? settings.language : void 0) != null) {
      // we found a language, provide it with priority 10
      return cb(settings.language, 10);
    } else {
      // otherwise we may parse a language out of the headers 
      return (await this.getHeaders(function(headers) {
        var j, language_code, language_range, language_tag, len, quality, ref, results1;
        if ((headers != null ? headers.HTTP_ACCEPT_LANGUAGE : void 0) != null) {
          ref = headers.HTTP_ACCEPT_LANGUAGE.split(',');
          // Need to parse out language preferences
          // console.log "#{headers.HTTP_ACCEPT_LANGUAGE}"
          results1 = [];
          for (j = 0, len = ref.length; j < len; j++) {
            language_range = ref[j];
            [language_tag, quality] = language_range.split(';');
            // console.log "#{language_tag}, #{quality}"
            if (language_tag === '*') {
              // let's give that half priority
              cb('English', -0.5);
            } else {
              language_code = language_tag.split('-')[0];
              // check if the language code is available
              if (language_code in exportObj.codeToLanguage) {
                // yep - use as language with reasonable priority
                cb(exportObj.codeToLanguage[language_code], 8);
              } else {
                // bullshit priority - we can't support what the user wants
                // (maybe he gave another option though in his browser settings)
                cb('English', -1);
              }
            }
            break;
          }
          return results1;
        } else {
          // no headers, callback with bullshit priority
          return cb('English', -1);
        }
      }));
    }
  }

  getCollectionCheck(settings, cb = $.noop) {
    if ((settings != null ? settings.collectioncheck : void 0) != null) {
      return cb(settings.collectioncheck);
    } else {
      this.collectioncheck = true;
      return cb(true);
    }
  }

  resetCollection(collection, cb = $.noop) {
    var post_args;
    post_args = {
      expansions: {},
      singletons: {},
      checks: {}
    };
    return $.post(`${this.server}/collection`, post_args).done(function(data, textStatus, jqXHR) {
      return cb(data.success);
    });
  }

  saveCollection(collection, cb = $.noop) {
    var post_args;
    post_args = {
      expansions: collection.expansions,
      singletons: collection.singletons,
      checks: collection.checks
    };
    return $.post(`${this.server}/collection`, post_args).done(function(data, textStatus, jqXHR) {
      return cb(data.success);
    });
  }

  loadCollection() {
    // Backend provides an empty collection if none exists yet for the user.
    return $.get(`${this.server}/collection`).done(function(data, textStatus, jqXHR) {
      var collection;
      collection = data.collection;
      return new exportObj.Collection({
        expansions: collection.expansions,
        singletons: collection.singletons,
        checks: collection.checks
      });
    });
  }

};

exportObj = typeof exports !== "undefined" && exports !== null ? exports : this;

// Assumes cards.js has been loaded
TYPES = ['pilots', 'upgrades', 'ships', 'damage'];

byName = function(a, b) {
  var a_name, b_name;
  if (a.display_name) {
    a_name = a.display_name.toLowerCase().replace(/[^a-zA-Z0-9]/g, '');
  } else {
    a_name = a.name.toLowerCase().replace(/[^a-zA-Z0-9]/g, '');
  }
  if (b.display_name) {
    b_name = b.display_name.toLowerCase().replace(/[^a-zA-Z0-9]/g, '');
  } else {
    b_name = b.name.toLowerCase().replace(/[^a-zA-Z0-9]/g, '');
  }
  if (a_name < b_name) {
    return -1;
  } else if (b_name < a_name) {
    return 1;
  } else {
    return 0;
  }
};

byPoints = function(a, b) {
  if (a.data.points < b.data.points) {
    return -1;
  } else if (b.data.points < a.data.points) {
    return 1;
  } else {
    return byName(a, b);
  }
};

String.prototype.capitalize = function() {
  return this.charAt(0).toUpperCase() + this.slice(1);
};

exportObj.CardBrowser = class CardBrowser {
  constructor(args) {
    var ref;
    // args
    this.container = $(args.container);
    // internals
    this.currently_selected = null;
    this.language = (ref = exportObj.currentLanguage) != null ? ref : 'English';
    this.prepareData();
    this.setupUI();
    this.setupHandlers();
  }

  // @renderList @sort_selector.val()
  setupUI() {
    var action, faction, factionless_option, i, j, keyword_item, keyword_items, keyword_list, keywords, l, len, len1, len2, len3, linkedaction, m, o, opt, pilot, ref, ref1, ref2, slot;
    this.container.append($.trim(`<div class="container-fluid xwing-card-browser">
    <div class="row">
        <div class="col-md-4">
            <div class="card card-search-container">
            <h5 class="card-title translated" defaultText="Card Search"></h5>
                <div class="advanced-search-container">
                    <div class = "card search-container general-search-container">
                        <h6 class="card-subtitle mb-3 text-muted version translated" defaultText="General"></h6>
                        <label class = "text-search advanced-search-label">
                        <strong class="translated" defaultText="Textsearch:"></strong>
                            <input type="search" placeholder="${exportObj.translate('ui', "Placeholder Textsearch Browser")}" class = "card-search-text">
                        </label>
                        <div class= "advanced-search-faction-selection-container">
                            <label class = "advanced-search-label select-available-slots">
                                <strong class="translated" defaultText="Factions:"></strong>
                                <select class="advanced-search-selection faction-selection" multiple="1" data-placeholder="${exportObj.translate('ui', "All factions")}"></select>
                            </label>
                        </div>
                        <div class = "advanced-search-point-selection-container">
                            <strong class="translated" defaultText="Point cost:"></strong>
                            <label class = "advanced-search-label set-minimum-points">
                                <span class="translated" defaultText="from"></span> <input type="number" class="minimum-point-cost advanced-search-number-input" value="0" /> 
                            </label>
                            <label class = "advanced-search-label set-maximum-points">
                                <span class="translated" defaultText="to"></span> <input type="number" class="maximum-point-cost advanced-search-number-input" value="20" /> 
                            </label>
                        </div>
                        <div class = "advanced-search-loadout-selection-container">
                            <strong class="translated" defaultText="Loadout cost:"></strong>
                            <label class = "advanced-search-label set-minimum-loadout">
                                <span class="translated" defaultText="from"></span> <input type="number" class="minimum-loadout-cost advanced-search-number-input" value="0" /> 
                            </label>
                            <label class = "advanced-search-label set-maximum-loadout">
                                <span class="translated" defaultText="to"></span> <input type="number" class="maximum-loadout-cost advanced-search-number-input" value="99" /> 
                            </label>
                        </div>
                        <div class = "advanced-search-collection-container">
                            <strong class="translated" defaultText="Owned copies:"></strong>
                            <label class = "advanced-search-label set-minimum-owned-copies">
                                <span class="translated" defaultText="from"></span> <input type="number" class="minimum-owned-copies advanced-search-number-input" value="0" /> 
                            </label>
                            <label class = "advanced-search-label set-maximum-owened-copies">
                                <span class="translated" defaultText="to"></span> <input type="number" class="maximum-owned-copies advanced-search-number-input" value="99" /> 
                            </label>
                        </div>
                        <div class = "advanced-search-misc-container">
                            <strong class="translated" defaultText="Misc:"></strong>
                            <label class = "advanced-search-label toggle-xwa">
                                <input type="checkbox" class="xwa-checkbox advanced-search-checkbox" checked="checked"/> <span class="translated" defaultText="Use XWA points"></span>
                            </label>
                            <label class = "advanced-search-label toggle-unique">
                                <input type="checkbox" class="unique-checkbox advanced-search-checkbox" /> <span class="translated" defaultText="Is unique"></span>
                            </label>
                            <label class = "advanced-search-label toggle-non-unique">
                                <input type="checkbox" class="non-unique-checkbox advanced-search-checkbox" /> <span class="translated" defaultText="Is not unique"></span>
                            </label>
                            <label class = "advanced-search-label toggle-limited">
                                <input type="checkbox" class="limited-checkbox advanced-search-checkbox" /> <span class="translated" defaultText="Is limited"></span>
                            </label>
                            <label class = "advanced-search-label toggle-standard">
                                <input type="checkbox" class="standard-checkbox advanced-search-checkbox" />  <span class="translated" defaultText="Standard legal"></span>
                            </label>
                        </div>
                    </div>
                    <div class = "card search-container ship-search-container">
                        <h6 class="card-subtitle mb-3 text-muted version translated" defaultText="Ships and Pilots"></h6>
                        <div class = "advanced-search-slot-available-container">
                            <label class = "advanced-search-label select-available-slots">
                                <strong class="translated" defaultText="Slots:"></strong>
                                <select class="advanced-search-selection slot-available-selection" multiple="1" data-placeholder="${exportObj.translate('ui', "noXYselected", "slots")}"></select>
                            </label>
                            <br />
                            <label class = "advanced-search-label toggle-unique">
                                <input type="checkbox" class="duplicate-slots-checkbox advanced-search-checkbox" /> <span class="translated" defaultText="Has multiple of the chosen slots"></span> 
                            </label>
                        </div>
                        <div class = "advanced-search-keyword-available-container">
                            <label class = "advanced-search-label select-available-keywords">
                                <strong class="translated" defaultText="Keywords:"></strong>
                                <select class="advanced-search-selection keyword-available-selection" multiple="1" data-placeholder="${exportObj.translate('ui', "noXYselected", "keywords")}"></select>
                            </label>
                        </div>
                        <div class = "advanced-search-actions-available-container">
                            <label class = "advanced-search-label select-available-actions">
                                <strong class="translated" defaultText="Actions:"></strong>
                                <select class="advanced-search-selection action-available-selection" multiple="1" data-placeholder="${exportObj.translate('ui', "noXYselected", "actions")}"></select>
                            </label>
                        </div>
                        <div class = "advanced-search-linkedactions-available-container">
                            <label class = "advanced-search-label select-available-linkedactions">
                                <strong class="translated" defaultText="Linked actions:"></strong>
                                <select class="advanced-search-selection linkedaction-available-selection" multiple="1" data-placeholder="${exportObj.translate('ui', "noXYselected", "actions")}"></select>
                            </label>
                        </div>
                        <div class = "advanced-search-ini-container">
                            <strong class="translated" defaultText="Initiative:"></strong>
                            <label class = "advanced-search-label set-minimum-ini">
                                <span class="translated" defaultText="from"></span> <input type="number" class="minimum-ini advanced-search-number-input" value="0" /> 
                            </label>
                            <label class = "advanced-search-label set-maximum-ini">
                                <span class="translated" defaultText="to"></span> <input type="number" class="maximum-ini advanced-search-number-input" value="6" /> 
                            </label>
                        </div>
                        <div class = "advanced-search-hull-container">
                            <strong class="translated" defaultText="Hull:"></strong>
                            <label class = "advanced-search-label set-minimum-hull">
                                <span class="translated" defaultText="from"></span> <input type="number" class="minimum-hull advanced-search-number-input" value="0" /> 
                            </label>
                            <label class = "advanced-search-label set-maximum-hull">
                                <span class="translated" defaultText="to"></span> <input type="number" class="maximum-hull advanced-search-number-input" value="12" /> 
                            </label>
                        </div>
                        <div class = "advanced-search-shields-container">
                            <strong class="translated" defaultText="Shields:"></strong>
                            <label class = "advanced-search-label set-minimum-shields">
                                <span class="translated" defaultText="from"></span> <input type="number" class="minimum-shields advanced-search-number-input" value="0" /> 
                            </label>
                            <label class = "advanced-search-label set-maximum-shields">
                                <span class="translated" defaultText="to"></span> <input type="number" class="maximum-shields advanced-search-number-input" value="6" /> 
                            </label>
                        </div>
                        <div class = "advanced-search-agility-container">
                            <strong class="translated" defaultText="Agility:"></strong>
                            <label class = "advanced-search-label set-minimum-agility">
                                <span class="translated" defaultText="from"></span> <input type="number" class="minimum-agility advanced-search-number-input" value="0" /> 
                            </label>
                            <label class = "advanced-search-label set-maximum-agility">
                                <span class="translated" defaultText="to"></span> <input type="number" class="maximum-agility advanced-search-number-input" value="3" /> 
                            </label>
                        </div>
                        <div class = "advanced-search-base-size-container">
                            <strong class="translated" defaultText="Base size:"></strong>
                            <label class = "advanced-search-label toggle-small-base">
                                <input type="checkbox" class="small-base-checkbox advanced-search-checkbox" checked="checked"/> <span class="translated" defaultText="Small"></span>
                            </label>
                            <label class = "advanced-search-label toggle-medium-base">
                                <input type="checkbox" class="medium-base-checkbox advanced-search-checkbox" checked="checked"/> <span class="translated" defaultText="Medium"></span>
                            </label>
                            <label class = "advanced-search-label toggle-large-base">
                                <input type="checkbox" class="large-base-checkbox advanced-search-checkbox" checked="checked"/> <span class="translated" defaultText="Large"></span>
                            </label>
                            <label class = "advanced-search-label toggle-huge-base">
                                <input type="checkbox" class="huge-base-checkbox advanced-search-checkbox" checked="checked"/> <span class="translated" defaultText="Huge"></span>
                            </label>
                        </div>
                        <div class = "advanced-search-attack-container">
                            <strong><i class="xwing-miniatures-font xwing-miniatures-font-frontarc"></i>:</strong>
                            <label class = "advanced-search-label set-minimum-attack">
                                <span class="translated" defaultText="from"></span> <input type="number" class="minimum-attack advanced-search-number-input" value="0" /> 
                            </label>
                            <label class = "advanced-search-label set-maximum-attack">
                                <span class="translated" defaultText="to"></span> <input type="number" class="maximum-attack advanced-search-number-input" value="5" /> 
                            </label>
                        </div>
                        <div class = "advanced-search-attackt-container">
                            <strong><i class="xwing-miniatures-font xwing-miniatures-font-singleturretarc"></i>:</strong>
                            <label class = "advanced-search-label set-minimum-attackt">
                                <span class="translated" defaultText="from"></span> <input type="number" class="minimum-attackt advanced-search-number-input" value="0" /> 
                            </label>
                            <label class = "advanced-search-label set-maximum-attackt">
                                <span class="translated" defaultText="to"></span> <input type="number" class="maximum-attackt advanced-search-number-input" value="5" /> 
                            </label>
                        </div>
                        <div class = "advanced-search-attackdt-container">
                            <strong><i class="xwing-miniatures-font xwing-miniatures-font-doubleturretarc"></i>:</strong>
                            <label class = "advanced-search-label set-minimum-attackdt">
                                <span class="translated" defaultText="from"></span> <input type="number" class="minimum-attackdt advanced-search-number-input" value="0" /> 
                            </label>
                            <label class = "advanced-search-label set-maximum-attackdt">
                                <span class="translated" defaultText="to"></span> <input type="number" class="maximum-attackdt advanced-search-number-input" value="5" /> 
                            </label>
                        </div>
                        <div class = "advanced-search-attackf-container">
                            <strong><i class="xwing-miniatures-font xwing-miniatures-font-fullfrontarc"></i>:</strong>
                            <label class = "advanced-search-label set-minimum-attackf">
                                <span class="translated" defaultText="from"></span> <input type="number" class="minimum-attackf advanced-search-number-input" value="0" /> 
                            </label>
                            <label class = "advanced-search-label set-maximum-attackf">
                                <span class="translated" defaultText="to"></span> <input type="number" class="maximum-attackf advanced-search-number-input" value="5" /> 
                            </label>
                        </div>
                        <div class = "advanced-search-attackb-container">
                            <strong><i class="xwing-miniatures-font xwing-miniatures-font-reararc"></i>:</strong>
                            <label class = "advanced-search-label set-minimum-attackb">
                                <span class="translated" defaultText="from"></span> <input type="number" class="minimum-attackb advanced-search-number-input" value="0" /> 
                            </label>
                            <label class = "advanced-search-label set-maximum-attackb">
                                <span class="translated" defaultText="to"></span> <input type="number" class="maximum-attackb advanced-search-number-input" value="5" /> 
                            </label>
                        </div>
                        <div class = "advanced-search-attackbull-container">
                            <strong><i class="xwing-miniatures-font xwing-miniatures-font-bullseyearc"></i>:</strong>
                            <label class = "advanced-search-label set-minimum-attackbull">
                                <span class="translated" defaultText="from"></span> <input type="number" class="minimum-attackbull advanced-search-number-input" value="0" /> 
                            </label>
                            <label class = "advanced-search-label set-maximum-attackbull">
                                <span class="translated" defaultText="to"></span> <input type="number" class="maximum-attackbull advanced-search-number-input" value="5" /> 
                            </label>
                        </div>
                    </div>
                    <div class = "card search-container other-stuff-search-container">
                        <h6 class="card-subtitle mb-3 text-muted version translated" defaultText="Other Stuff"></h6>
                        <div class = "advanced-search-slot-used-container">
                            <label class = "advanced-search-label select-used-slots">
                                <strong class="translated" defaultText="Used slot:"></strong>
                                <select class="advanced-search-selection slot-used-selection" multiple="1" data-placeholder="${exportObj.translate('ui', "noXYselected", "slots")}"></select>
                            </label>
                        </div>
                        <div class = "advanced-search-slot-used-second-slot-container">
                            <label class = "advanced-search-label select-used-second-slots">
                                <strong class="translated" defaultText="Used double-slot:"></strong>
                                <select class="advanced-search-selection slot-used-second-selection" multiple="1" data-placeholder="${exportObj.translate('ui', "noXYselected", "slots")}"></select>
                            </label>
                            <br />
                            <label class = "advanced-search-label has-a-second-slot">
                                <input type="checkbox" class="advanced-search-checkbox has-a-second-slot-checkbox" /> <span class="translated" defaultText="Only upgrades requiring multiple slots"></span>
                            </label>
                        </div>
                        <div class = "advanced-search-charge-container">
                            <strong class="translated" defaultText="Charges:"></strong>
                            <label class = "advanced-search-label set-minimum-charge">
                                <span class="translated" defaultText="from"></span> <input type="number" class="minimum-charge advanced-search-number-input" value="0" /> 
                            </label>
                            <label class = "advanced-search-label set-maximum-charge">
                                <span class="translated" defaultText="to"></span> <input type="number" class="maximum-charge advanced-search-number-input" value="5" /> 
                            </label>
                            <br />
                            <label class = "advanced-search-label has-recurring-charge">
                                <input type="checkbox" class="advanced-search-checkbox has-recurring-charge-checkbox" checked="checked"/> <span class="translated" defaultText="Recurring"></span>
                            </label>
                            <label class = "advanced-search-label has-not-recurring-charge">
                                <input type="checkbox" class="advanced-search-checkbox has-not-recurring-charge-checkbox" checked="checked"/> <span class="translated" defaultText="Not recurring"></span>
                            </label>
                        <div class = "advanced-search-force-container">
                            <strong class="translated" defaultText="Force:"></strong>
                            <label class = "advanced-search-label set-minimum-force">
                                <span class="translated" defaultText="from"></span> <input type="number" class="minimum-force advanced-search-number-input" value="0" /> 
                            </label>
                            <label class = "advanced-search-label set-maximum-force">
                                <span class="translated" defaultText="to"></span> <input type="number" class="maximum-force advanced-search-number-input" value="3" /> 
                            </label>
                        </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4 card-selecting-area">
            <span class="translate sort-cards-by" defaultText="Sort cards by"></span><span class="translated" defaultText="Sort by">:</span> <select class="sort-by">
                <option value="name" class="translated" defaultText="Name"></option>
                <option value="source" class="translated" defaultText="Source"></option>
                <option value="type-by-points" class="translated" defaultText="Type (by Points)"></option>
                <option value="type-by-name" selected="1" class="translated" defaultText="Type (by Name)" selected="selected">${exportObj.translate('ui', 'Type (by Name)')}</option>
            </select>
            <div class="card-selector-container">

            </div>
            <br>
            <div class="card-viewer-conditions-container">
            </div>
        </div>
        <div class="col-md-4">
            <div class="card-viewer-container">
            </div>
        </div>
    </div>
</div>`));
    this.card_selector_container = $(this.container.find('.xwing-card-browser .card-selector-container'));
    this.card_viewer_container = $(this.container.find('.xwing-card-browser .card-viewer-container'));
    this.card_viewer_container.append($.trim(exportObj.builders[7].createInfoContainerUI(false)));
    this.card_viewer_container.hide();
    this.card_viewer_conditions_container = $(this.container.find('.xwing-card-browser .card-viewer-conditions-container'));
    this.card_viewer_conditions_container.hide();
    this.advanced_search_container = $(this.container.find('.xwing-card-browser .advanced-search-container'));
    this.sort_selector = $(this.container.find('select.sort-by'));
    this.sort_selector.select2({
      minimumResultsForSearch: -1
    });
    // TODO: Make added inputs easy accessible
    this.card_search_text = ($(this.container.find('.xwing-card-browser .card-search-text')))[0];
    this.faction_selection = $(this.container.find('.xwing-card-browser select.faction-selection'));
    ref = exportObj.pilotsByFactionXWS;
    for (faction in ref) {
      pilot = ref[faction];
      opt = $(document.createElement('OPTION'));
      opt.val(faction);
      opt.text(exportObj.translate('faction', faction));
      this.faction_selection.append(opt);
    }
    factionless_option = $(document.createElement('OPTION'));
    factionless_option.val("Factionless");
    factionless_option.text(exportObj.translate('faction', "Factionless"));
    this.faction_selection.append(factionless_option);
    this.faction_selection.select2({
      minimumResultsForSearch: $.isMobile() ? -1 : 0
    });
    this.minimum_point_costs = ($(this.container.find('.xwing-card-browser .minimum-point-cost')))[0];
    this.maximum_point_costs = ($(this.container.find('.xwing-card-browser .maximum-point-cost')))[0];
    this.minimum_loadout_costs = ($(this.container.find('.xwing-card-browser .minimum-loadout-cost')))[0];
    this.maximum_loadout_costs = ($(this.container.find('.xwing-card-browser .maximum-loadout-cost')))[0];
    this.use_xwa_points = ($(this.container.find('.xwing-card-browser .xwa-checkbox')))[0];
    this.standard_checkbox = ($(this.container.find('.xwing-card-browser .standard-checkbox')))[0];
    this.unique_checkbox = ($(this.container.find('.xwing-card-browser .unique-checkbox')))[0];
    this.non_unique_checkbox = ($(this.container.find('.xwing-card-browser .non-unique-checkbox')))[0];
    this.limited_checkbox = ($(this.container.find('.xwing-card-browser .limited-checkbox')))[0];
    this.base_size_checkboxes = {
      Small: ($(this.container.find('.xwing-card-browser .small-base-checkbox')))[0],
      Medium: ($(this.container.find('.xwing-card-browser .medium-base-checkbox')))[0],
      Large: ($(this.container.find('.xwing-card-browser .large-base-checkbox')))[0],
      Huge: ($(this.container.find('.xwing-card-browser .huge-base-checkbox')))[0]
    };
    this.slot_available_selection = $(this.container.find('.xwing-card-browser select.slot-available-selection'));
    for (slot in exportObj.upgradesBySlotCanonicalName) {
      opt = $(document.createElement('OPTION'));
      opt.val(slot);
      opt.text(exportObj.translate('slot', slot));
      this.slot_available_selection.append(opt);
    }
    this.slot_available_selection.select2({
      minimumResultsForSearch: $.isMobile() ? -1 : 0
    });
    this.keyword_available_selection = $(this.container.find('.xwing-card-browser select.keyword-available-selection'));
    keyword_list = [];
    for (keywords in exportObj.pilotsByKeyword) {
      keyword_items = keywords.split(",");
      for (j = 0, len = keyword_items.length; j < len; j++) {
        i = keyword_items[j];
        if ((keyword_list.indexOf(i) < 0) && (i !== "undefined")) {
          keyword_list.push(i);
        }
      }
    }
    keyword_list.sort();
    for (l = 0, len1 = keyword_list.length; l < len1; l++) {
      keyword_item = keyword_list[l];
      opt = $(document.createElement('OPTION'));
      opt.val(keyword_item);
      opt.text(exportObj.translate('keyword', keyword_item));
      this.keyword_available_selection.append(opt);
    }
    this.keyword_available_selection.select2({
      minimumResultsForSearch: $.isMobile() ? -1 : 0
    });
    this.duplicateslots = ($(this.container.find('.xwing-card-browser .duplicate-slots-checkbox')))[0];
    this.action_available_selection = $(this.container.find('.xwing-card-browser select.action-available-selection'));
    ref1 = ["Evade", "Focus", "Lock", "Boost", "Barrel Roll", "Calculate", "Reinforce", "Rotate Arc", "Coordinate", "Slam", "Reload", "Jam", "Cloak"].sort();
    // ToDo: This does not seem like the correct place to have a list of all actions. Don't we have that elsewhere?!
    for (m = 0, len2 = ref1.length; m < len2; m++) {
      action = ref1[m];
      opt = $(document.createElement('OPTION'));
      opt.text(exportObj.translate('action', action));
      opt.val(action);
      this.action_available_selection.append(opt);
    }
    this.action_available_selection.select2({
      minimumResultsForSearch: $.isMobile() ? -1 : 0
    });
    this.linkedaction_available_selection = $(this.container.find('.xwing-card-browser select.linkedaction-available-selection'));
    ref2 = ["Evade", "Focus", "Lock", "Boost", "Barrel Roll", "Calculate", "Reinforce", "Rotate Arc", "Coordinate", "Slam", "Reload", "Jam", "Cloak"].sort();
    for (o = 0, len3 = ref2.length; o < len3; o++) {
      linkedaction = ref2[o];
      opt = $(document.createElement('OPTION'));
      opt.text(exportObj.translate('action', linkedaction));
      opt.val(linkedaction);
      this.linkedaction_available_selection.append(opt);
    }
    this.linkedaction_available_selection.select2({
      minimumResultsForSearch: $.isMobile() ? -1 : 0
    });
    this.slot_used_selection = $(this.container.find('.xwing-card-browser select.slot-used-selection'));
    for (slot in exportObj.upgradesBySlotCanonicalName) {
      opt = $(document.createElement('OPTION'));
      opt.text(exportObj.translate('slot', slot));
      opt.val(slot);
      this.slot_used_selection.append(opt);
    }
    this.slot_used_selection.select2({
      minimumResultsForSearch: $.isMobile() ? -1 : 0
    });
    this.slot_used_second_selection = $(this.container.find('.xwing-card-browser select.slot-used-second-selection'));
    for (slot in exportObj.upgradesBySlotCanonicalName) {
      opt = $(document.createElement('OPTION'));
      opt.text(exportObj.translate('slot', slot));
      opt.val(slot);
      this.slot_used_second_selection.append(opt);
    }
    this.slot_used_second_selection.select2({
      minimumResultsForSearch: $.isMobile() ? -1 : 0
    });
    this.minimum_charge = ($(this.container.find('.xwing-card-browser .minimum-charge')))[0];
    this.maximum_charge = ($(this.container.find('.xwing-card-browser .maximum-charge')))[0];
    this.minimum_ini = ($(this.container.find('.xwing-card-browser .minimum-ini')))[0];
    this.maximum_ini = ($(this.container.find('.xwing-card-browser .maximum-ini')))[0];
    this.minimum_force = ($(this.container.find('.xwing-card-browser .minimum-force')))[0];
    this.maximum_force = ($(this.container.find('.xwing-card-browser .maximum-force')))[0];
    this.minimum_hull = ($(this.container.find('.xwing-card-browser .minimum-hull')))[0];
    this.maximum_hull = ($(this.container.find('.xwing-card-browser .maximum-hull')))[0];
    this.minimum_shields = ($(this.container.find('.xwing-card-browser .minimum-shields')))[0];
    this.maximum_shields = ($(this.container.find('.xwing-card-browser .maximum-shields')))[0];
    this.minimum_agility = ($(this.container.find('.xwing-card-browser .minimum-agility')))[0];
    this.maximum_agility = ($(this.container.find('.xwing-card-browser .maximum-agility')))[0];
    this.minimum_attack = ($(this.container.find('.xwing-card-browser .minimum-attack')))[0];
    this.maximum_attack = ($(this.container.find('.xwing-card-browser .maximum-attack')))[0];
    this.minimum_attackt = ($(this.container.find('.xwing-card-browser .minimum-attackt')))[0];
    this.maximum_attackt = ($(this.container.find('.xwing-card-browser .maximum-attackt')))[0];
    this.minimum_attackdt = ($(this.container.find('.xwing-card-browser .minimum-attackdt')))[0];
    this.maximum_attackdt = ($(this.container.find('.xwing-card-browser .maximum-attackdt')))[0];
    this.minimum_attackf = ($(this.container.find('.xwing-card-browser .minimum-attackf')))[0];
    this.maximum_attackf = ($(this.container.find('.xwing-card-browser .maximum-attackf')))[0];
    this.minimum_attackb = ($(this.container.find('.xwing-card-browser .minimum-attackb')))[0];
    this.maximum_attackb = ($(this.container.find('.xwing-card-browser .maximum-attackb')))[0];
    this.minimum_attackbull = ($(this.container.find('.xwing-card-browser .minimum-attackbull')))[0];
    this.maximum_attackbull = ($(this.container.find('.xwing-card-browser .maximum-attackbull')))[0];
    this.hassecondslot = ($(this.container.find('.xwing-card-browser .has-a-second-slot-checkbox')))[0];
    this.recurring_charge = ($(this.container.find('.xwing-card-browser .has-recurring-charge-checkbox')))[0];
    this.not_recurring_charge = ($(this.container.find('.xwing-card-browser .has-not-recurring-charge-checkbox')))[0];
    this.minimum_owned_copies = ($(this.container.find('.xwing-card-browser .minimum-owned-copies')))[0];
    this.maximum_owned_copies = ($(this.container.find('.xwing-card-browser .maximum-owned-copies')))[0];
    return exportObj.translateUIElements(this.container);
  }

  setupHandlers() {
    var basesize, checkbox, ref;
    this.sort_selector.change((e) => {
      return this.renderList(this.sort_selector.val());
    });
    
    //apparently @renderList takes a long time to load, so moving the loading to on button press
    $("#browserTab").on('click', (e) => {
      return this.renderList(this.sort_selector.val());
    });
    $(window).on('xwing:afterLanguageLoad', (e, language, cb = $.noop) => {
      //if @language != language
      this.language = language;
      return this.prepareData();
    }).on('xwing-collection:created', (e, collection) => {
      return this.collection = collection;
    }).on('xwing-collection:destroyed', (e, collection) => {
      return this.collection = null;
    });
    this.card_search_text.oninput = () => {
      return this.renderList(this.sort_selector.val());
    };
    // I find myself often searching for just text. To speed this up, we skip
    // everything else until the first one is changed        
    this.skip_nontext_search = true;
    this.faction_selection[0].onchange = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    ref = this.base_size_checkboxes;
    for (basesize in ref) {
      checkbox = ref[basesize];
      checkbox.onclick = () => {
        return this.renderList_advanced(this.sort_selector.val());
      };
    }
    this.minimum_point_costs.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.maximum_point_costs.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.minimum_loadout_costs.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.maximum_loadout_costs.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.standard_checkbox.onclick = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.use_xwa_points.onclick = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.unique_checkbox.onclick = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.non_unique_checkbox.onclick = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.limited_checkbox.onclick = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.slot_available_selection[0].onchange = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.keyword_available_selection[0].onchange = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.duplicateslots.onclick = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.action_available_selection[0].onchange = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.linkedaction_available_selection[0].onchange = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.slot_used_selection[0].onchange = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.slot_used_second_selection[0].onchange = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.not_recurring_charge.onclick = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.recurring_charge.onclick = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.hassecondslot.onclick = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.minimum_charge.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.maximum_charge.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.minimum_ini.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.maximum_ini.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.minimum_hull.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.maximum_hull.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.minimum_force.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.maximum_force.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.minimum_shields.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.maximum_shields.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.minimum_agility.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.maximum_agility.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.minimum_attack.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.maximum_attack.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.minimum_attackt.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.maximum_attackt.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.minimum_attackdt.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.maximum_attackdt.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.minimum_attackf.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.maximum_attackf.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.minimum_attackb.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.maximum_attackb.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.minimum_attackbull.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.maximum_attackbull.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    this.minimum_owned_copies.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
    return this.maximum_owned_copies.oninput = () => {
      return this.renderList_advanced(this.sort_selector.val());
    };
  }

  getPoints(a) {
    if (this.use_xwa_points.checked && (a.pointsxwa != null)) {
      return a.pointsxwa;
    }
    return a.points;
  }

  getLoadout(a) {
    if (this.use_xwa_points.checked && (a.loadoutxwa != null)) {
      return a.loadoutxwa;
    }
    return a.loadout;
  }

  getSlots(a) {
    if (this.use_xwa_points.checked && (a.slotsxwa != null)) {
      return a.slotsxwa;
    }
    return a.slots;
  }

  prepareData() {
    var card, card_data, card_name, j, l, len, len1, len2, len3, len4, len5, m, o, q, ref, ref1, ref2, ref3, results1, sorted_sources, sorted_types, source, type, upgrade_text, y;
    this.all_cards = [];
    for (j = 0, len = TYPES.length; j < len; j++) {
      type = TYPES[j];
      if (type === 'upgrades') {
        this.all_cards = this.all_cards.concat((function() {
          var ref, results1;
          ref = exportObj[type];
          results1 = [];
          for (card_name in ref) {
            card_data = ref[card_name];
            results1.push({
              name: card_data.name,
              display_name: card_data.display_name,
              type: exportObj.translate('ui', 'upgradeHeader', card_data.slot),
              data: card_data,
              orig_type: card_data.slot
            });
          }
          return results1;
        })());
      } else if (type === 'damage') {
        this.all_cards = this.all_cards.concat((function() {
          var ref, results1;
          ref = exportObj[type];
          results1 = [];
          for (card_name in ref) {
            card_data = ref[card_name];
            results1.push({
              name: card_data.name,
              display_name: card_data.display_name,
              type: exportObj.translate('ui', 'damageHeader', card_data.type),
              data: card_data,
              orig_type: "Damage"
            });
          }
          return results1;
        })());
      } else {
        this.all_cards = this.all_cards.concat((function() {
          var ref, results1;
          ref = exportObj[type];
          results1 = [];
          for (card_name in ref) {
            card_data = ref[card_name];
            results1.push({
              name: card_data.name,
              display_name: card_data.display_name,
              type: exportObj.translate('singular', type),
              data: card_data,
              orig_type: exportObj.translateToLang('English', 'singular', type)
            });
          }
          return results1;
        })());
      }
    }
    this.types = (function() {
      var l, len1, ref, results1;
      ref = ['Pilot', 'Ship'];
      results1 = [];
      for (l = 0, len1 = ref.length; l < len1; l++) {
        type = ref[l];
        results1.push(exportObj.translate('types', type));
      }
      return results1;
    })();
    ref = exportObj.upgrades;
    for (card_name in ref) {
      card_data = ref[card_name];
      upgrade_text = exportObj.translate('ui', 'upgradeHeader', card_data.slot);
      if (indexOf.call(this.types, upgrade_text) < 0) {
        this.types.push(upgrade_text);
      }
    }
    ref1 = exportObj.damage;
    for (card_name in ref1) {
      card_data = ref1[card_name];
      upgrade_text = exportObj.translate('ui', 'damageHeader', card_data.type);
      if (indexOf.call(this.types, upgrade_text) < 0) {
        this.types.push(upgrade_text);
      }
    }
    this.all_cards.sort(byName);
    this.sources = [];
    ref2 = this.all_cards;
    for (l = 0, len1 = ref2.length; l < len1; l++) {
      card = ref2[l];
      ref3 = card.data.sources;
      for (m = 0, len2 = ref3.length; m < len2; m++) {
        source = ref3[m];
        if (indexOf.call(this.sources, source) < 0) {
          this.sources.push(source);
        }
      }
    }
    sorted_types = this.types.sort();
    sorted_sources = this.sources.sort();
    this.cards_by_type_name = {};
    for (o = 0, len3 = sorted_types.length; o < len3; o++) {
      type = sorted_types[o];
      this.cards_by_type_name[type] = ((function() {
        var len4, q, ref4, results1;
        ref4 = this.all_cards;
        results1 = [];
        for (q = 0, len4 = ref4.length; q < len4; q++) {
          card = ref4[q];
          if (card.type === type) {
            results1.push(card);
          }
        }
        return results1;
      }).call(this)).sort(byName);
    }
    // TODO: Functionality should not rely on translations. Here the translated type is used. Replace with orig_type and just display translation. Don't use it internally...
    this.cards_by_type_points = {};
    for (q = 0, len4 = sorted_types.length; q < len4; q++) {
      type = sorted_types[q];
      this.cards_by_type_points[type] = ((function() {
        var len5, ref4, results1, y;
        ref4 = this.all_cards;
        results1 = [];
        for (y = 0, len5 = ref4.length; y < len5; y++) {
          card = ref4[y];
          if (card.type === type) {
            results1.push(card);
          }
        }
        return results1;
      }).call(this)).sort(byPoints);
    }
    this.cards_by_source = {};
    results1 = [];
    for (y = 0, len5 = sorted_sources.length; y < len5; y++) {
      source = sorted_sources[y];
      results1.push(this.cards_by_source[source] = ((function() {
        var len6, ref4, results2, z;
        ref4 = this.all_cards;
        results2 = [];
        for (z = 0, len6 = ref4.length; z < len6; z++) {
          card = ref4[z];
          if (indexOf.call(card.data.sources, source) >= 0) {
            results2.push(card);
          }
        }
        return results2;
      }).call(this)).sort(byName));
    }
    return results1;
  }

  renderList_advanced(sort_by = 'name') {
    this.skip_nontext_search = false;
    return this.renderList(sort_by);
  }

  renderList(sort_by = 'name') {
    var card, card_added, j, l, len, len1, len2, len3, len4, len5, len6, m, o, optgroup, q, ref, ref1, ref2, ref3, ref4, ref5, ref6, source, type, y, z;
    // sort_by is one of `name`, `type-by-name`, `source`, `type-by-points`

    // Renders multiselect to container
    // Selects previously selected card if there is one
    if (this.use_xwa_points.checked != null) {
      exportObj.builders[7].isXwa = this.use_xwa_points.checked;
    }
    if (this.card_selector != null) {
      this.card_selector.empty();
    } else {
      this.card_selector = $(document.createElement('SELECT'));
      this.card_selector.addClass('card-selector');
      this.card_selector.attr('size', 25);
      this.card_selector_container.append(this.card_selector);
    }
    this.setupSearch();
    switch (sort_by) {
      case 'type-by-name':
        ref = this.types;
        for (j = 0, len = ref.length; j < len; j++) {
          type = ref[j];
          optgroup = $(document.createElement('OPTGROUP'));
          optgroup.attr('label', type);
          card_added = false;
          ref1 = this.cards_by_type_name[type];
          for (l = 0, len1 = ref1.length; l < len1; l++) {
            card = ref1[l];
            if (this.checkSearchCriteria(card)) {
              this.addCardTo(optgroup, card);
              card_added = true;
            }
          }
          if (card_added) {
            this.card_selector.append(optgroup);
          }
        }
        break;
      case 'type-by-points':
        ref2 = this.types;
        for (m = 0, len2 = ref2.length; m < len2; m++) {
          type = ref2[m];
          optgroup = $(document.createElement('OPTGROUP'));
          optgroup.attr('label', type);
          card_added = false;
          ref3 = this.cards_by_type_points[type];
          for (o = 0, len3 = ref3.length; o < len3; o++) {
            card = ref3[o];
            if (this.checkSearchCriteria(card)) {
              this.addCardTo(optgroup, card);
              card_added = true;
            }
          }
          if (card_added) {
            this.card_selector.append(optgroup);
          }
        }
        break;
      case 'source':
        ref4 = this.sources;
        for (q = 0, len4 = ref4.length; q < len4; q++) {
          source = ref4[q];
          optgroup = $(document.createElement('OPTGROUP'));
          optgroup.attr('label', exportObj.translate('sources', source));
          card_added = false;
          ref5 = this.cards_by_source[source];
          for (y = 0, len5 = ref5.length; y < len5; y++) {
            card = ref5[y];
            if (this.checkSearchCriteria(card)) {
              this.addCardTo(optgroup, card);
              card_added = true;
            }
          }
          if (card_added) {
            this.card_selector.append(optgroup);
          }
        }
        break;
      default:
        ref6 = this.all_cards;
        for (z = 0, len6 = ref6.length; z < len6; z++) {
          card = ref6[z];
          if (this.checkSearchCriteria(card)) {
            this.addCardTo(this.card_selector, card);
          }
        }
    }
    return this.card_selector.change((e) => {
      return this.renderCard($(this.card_selector.find(':selected')));
    });
  }

  renderCard(card) {
    var add_opts, condition, conditions, data, display_name, j, len, name, orig_type, ref;
    // Renders card to card container
    display_name = card.data('display_name');
    name = card.data('name');
    // type = card.data 'type'
    data = card.data('card');
    orig_type = card.data('orig_type');
    if (!(orig_type === 'Pilot' || orig_type === 'Ship' || orig_type === 'Quickbuild' || orig_type === 'Damage')) {
      add_opts = {
        addon_type: orig_type
      };
      orig_type = 'Addon';
    }
    if (orig_type === 'Pilot') {
      this.card_viewer_container.find('tr.info-faction').show(); // this information is not shown in the builder, since the faction is clear there, but usefull here. 
    }
    this.card_viewer_container.show();
    exportObj.builders[7].showTooltip(orig_type, data, add_opts != null ? add_opts : {}, this.card_viewer_container); // we use the render method from the squad builder, cause it works.
    
    // Conditions
    if ((data != null ? data.applies_condition : void 0) != null) {
      conditions = new Set();
      if (data.applies_condition instanceof Array) {
        ref = data.applies_condition;
        for (j = 0, len = ref.length; j < len; j++) {
          condition = ref[j];
          conditions.add(exportObj.conditionsByCanonicalName[condition]);
        }
      } else {
        conditions.add(exportObj.conditionsByCanonicalName[data.applies_condition]);
      }
      this.card_viewer_conditions_container.text('');
      conditions.forEach((condition) => {
        var condition_container;
        condition_container = $(document.createElement('div'));
        condition_container.addClass('conditions-container d-flex flex-wrap');
        condition_container.append(conditionToHTML(condition));
        return this.card_viewer_conditions_container.append(condition_container);
      });
      return this.card_viewer_conditions_container.show();
    } else {
      return this.card_viewer_conditions_container.hide();
    }
  }

  addCardTo(container, card) {
    var option;
    option = $(document.createElement('OPTION'));
    option.text(`${card.display_name ? card.display_name : card.name} (${this.getPoints(card.data) != null ? this.getPoints(card.data) : (card.data.quantity != null ? card.data.quantity + 'x' : '*')}${this.getLoadout(card.data) != null ? `/${this.getLoadout(card.data)}` : ''})`);
    option.data('name', card.name);
    option.data('display_name', card.display_name);
    option.data('type', card.type);
    option.data('card', card.data);
    option.data('orig_type', card.orig_type);
    if (this.getCollectionNumber(card) === 0) {
      option[0].classList.add('result-not-in-collection');
    }
    return $(container).append(option);
  }

  getCollectionNumber(card) {
    var owned_copies, ref, ref1, ref2, ref3, ref4, ref5;
    // returns number of copies of the given card in the collection, or -1 if no collection loaded
    if (!((exportObj.builders[7].collection != null) && (exportObj.builders[7].collection.counts != null))) {
      return -1;
    }
    owned_copies = 0;
    switch (card.orig_type) {
      case 'Pilot':
        owned_copies = (ref = (ref1 = exportObj.builders[7].collection.counts.pilot) != null ? ref1[card.name] : void 0) != null ? ref : 0;
        break;
      case 'Ship':
        owned_copies = (ref2 = (ref3 = exportObj.builders[7].collection.counts.ship) != null ? ref3[card.name] : void 0) != null ? ref2 : 0; // type is e.g. astromech
        break;
      default:
        owned_copies = (ref4 = (ref5 = exportObj.builders[7].collection.counts.upgrade) != null ? ref5[card.name] : void 0) != null ? ref4 : 0;
    }
    return owned_copies;
  }

  setupSearch() {
    // do some stuff like fetching text inputs only once, as running it for each card is time consuming
    this.searchInputs = {
      "text": this.card_search_text.value.toLowerCase(),
      "factions": this.faction_selection.val(),
      "required_slots": this.slot_available_selection.val(),
      "required_actions": this.action_available_selection.val(),
      "required_linked_actions": this.linkedaction_available_selection.val(),
      "required_keywords": this.keyword_available_selection.val(),
      "used_slots": this.slot_used_selection.val(),
      "used_second_slots": this.slot_used_second_selection.val()
    };
    if (indexOf.call(this.searchInputs.factions, "Factionless") >= 0) {
      return this.searchInputs.factions.push(void 0);
    }
  }

  checkSearchCriteria(card) {
    var action, actions, adds, all_factions, faction, faction_matches, hasDuplicates, i1, j, j1, k1, keyword, keywords, l, l1, len, len1, len10, len11, len12, len13, len14, len15, len16, len2, len3, len4, len5, len6, len7, len8, len9, m, m1, matches, matching_loadout, matching_points, n1, name, new_actions, o, o1, owned_copies, p1, pilot, pilots, points, q, q1, r1, ref, ref1, ref10, ref11, ref12, ref13, ref14, ref15, ref16, ref17, ref18, ref2, ref3, ref4, ref5, ref6, ref7, ref8, ref9, required_actions, required_keywords, required_linked_actions, required_slots, s, selected_factions, ship, size_matches, slot, slots, standard_legal, text_in_ship, text_search, used_second_slots, used_slots, variablepoints, y, z;
    // check for text search
    if (this.searchInputs.text != null) {
      text_search = card.name.toLowerCase().indexOf(this.searchInputs.text) > -1 || (card.data.text && card.data.text.toLowerCase().indexOf(this.searchInputs.text) > -1) || (card.display_name && card.display_name.toLowerCase().indexOf(this.searchInputs.text) > -1);
      if (!text_search) {
        if (!card.data.ship) {
          return false;
        }
        ship = card.data.ship;
        if (ship instanceof Array) {
          text_in_ship = false;
          for (j = 0, len = ship.length; j < len; j++) {
            s = ship[j];
            if (s.toLowerCase().indexOf(this.searchInputs.text) > -1 || (exportObj.ships[s].display_name && exportObj.ships[s].display_name.toLowerCase().indexOf(this.searchInputs.text) > -1)) {
              text_in_ship = true;
              break;
            }
          }
          if (!text_in_ship) {
            return false;
          }
        } else {
          if (!(ship.toLowerCase().indexOf(this.searchInputs.text) > -1 || (exportObj.ships[ship].display_name && exportObj.ships[ship].display_name.toLowerCase().indexOf(this.searchInputs.text) > -1))) {
            return false;
          }
        }
      }
    }
    
    // if no search field has changed, we are done here. 
    if (this.skip_nontext_search) {
      return true;
    }
    all_factions = (function() {
      var ref, results1;
      ref = exportObj.pilotsByFactionXWS;
      results1 = [];
      for (faction in ref) {
        pilot = ref[faction];
        results1.push(faction);
      }
      return results1;
    })();
    selected_factions = this.searchInputs.factions;
    if (selected_factions.length > 0) {
      if (!((ref = card.data.faction, indexOf.call(selected_factions, ref) >= 0) || card.orig_type === 'Ship' || card.data.faction instanceof Array)) {
        return false;
      }
      if (card.data.faction instanceof Array) {
        faction_matches = false;
        ref1 = card.data.faction;
        for (l = 0, len1 = ref1.length; l < len1; l++) {
          faction = ref1[l];
          if (indexOf.call(selected_factions, faction) >= 0) {
            faction_matches = true;
            break;
          }
        }
        if (!faction_matches) {
          return false;
        }
      }
      if (card.orig_type === 'Ship') {
        faction_matches = false;
        ref2 = card.data.factions;
        for (m = 0, len2 = ref2.length; m < len2; m++) {
          faction = ref2[m];
          if (indexOf.call(selected_factions, faction) >= 0) {
            faction_matches = true;
            break;
          }
        }
        if (!faction_matches) {
          return false;
        }
      }
    } else {
      selected_factions = all_factions;
    }
    // check if standard only matches
    if (this.standard_checkbox.checked) {
      standard_legal = false;
      ref3 = (card.data.faction != null ? (Array.isArray(card.data.faction) ? card.data.faction : [card.data.faction]) : selected_factions);
      // check all factions specified by the card (which might be a single faction or an array of factions), or all selected factions if card does not specify any
      for (o = 0, len3 = ref3.length; o < len3; o++) {
        faction = ref3[o];
        if (indexOf.call(selected_factions, faction) < 0) { // e.g. ships should only be displayed if a legal faction is selected
          continue;
        }
        standard_legal = standard_legal || exportObj.standardCheckBrowser(card.data, faction, card.orig_type);
      }
      if (!standard_legal) {
        return false;
      }
    }
    // check for slot requirements
    required_slots = this.searchInputs.required_slots;
    if (required_slots.length > 0) {
      slots = this.getSlots(card.data);
      for (q = 0, len4 = required_slots.length; q < len4; q++) {
        slot = required_slots[q];
        // special case for hardpoints
        if (!(((slot === "Torpedo") || (slot === "Missile") || (slot === "Cannon")) && ((slots != null) && (indexOf.call(slots, "HardpointShip") >= 0)))) {
          if (!((slots != null) && indexOf.call(slots, slot) >= 0)) {
            return false;
          }
        }
        // check for duplciates
        if (this.duplicateslots.checked) {
          hasDuplicates = slots.filter(function(x, i, self) {
            return (self.indexOf(x) === i && i !== self.lastIndexOf(x)) && (x === slot);
          });
          if (hasDuplicates.length === 0) {
            return false;
          }
        }
      }
    }
    // check for keyword requirements
    required_keywords = this.searchInputs.required_keywords;
    if (required_keywords.length > 0) {
      keywords = card.data.keyword;
      for (y = 0, len5 = required_keywords.length; y < len5; y++) {
        keyword = required_keywords[y];
        if (!((keywords != null) && indexOf.call(keywords, keyword) >= 0)) {
          // special case for hardpoints
          return false;
        }
      }
    }
    // check for action requirements
    required_actions = this.searchInputs.required_actions;
    required_linked_actions = this.searchInputs.required_linked_actions;
    if ((required_actions.length > 0) || (required_linked_actions.length > 0)) {
      actions = (ref4 = card.data.actions) != null ? ref4 : [];
      if (card.orig_type === 'Pilot') {
        actions = (ref5 = (ref6 = card.data.ship_override) != null ? ref6.actions : void 0) != null ? ref5 : exportObj.ships[card.data.ship].actions;
        actions = actions.concat((ref7 = (ref8 = card.data.ship_override) != null ? ref8.actionsred : void 0) != null ? ref7 : exportObj.ships[card.data.ship].actionsred);
        if ((card.data.keyword != null) && (indexOf.call(card.data.keyword, "Droid") >= 0)) {
          // Droid conversion of Focus to Calculate
          new_actions = [];
          for (z = 0, len6 = actions.length; z < len6; z++) {
            action = actions[z];
            if (action != null) {
              new_actions.push(action.replace("Focus", "Calculate"));
            }
          }
          actions = new_actions;
        }
      }
    }
    ref9 = required_actions != null ? required_actions : [];
    for (i1 = 0, len7 = ref9.length; i1 < len7; i1++) {
      action = ref9[i1];
      if (!((actions != null) && ((indexOf.call(actions, action) >= 0) || (ref10 = "F-" + action, indexOf.call(actions, ref10) >= 0) || (ref11 = "R-" + action, indexOf.call(actions, ref11) >= 0)))) {
        return false;
      }
    }
    ref12 = required_linked_actions != null ? required_linked_actions : [];
    for (j1 = 0, len8 = ref12.length; j1 < len8; j1++) {
      action = ref12[j1];
      if (!((actions != null) && ((ref13 = "R> " + action, indexOf.call(actions, ref13) >= 0) || (ref14 = "> " + action, indexOf.call(actions, ref14) >= 0)))) {
        return false;
      }
    }
    // check if point costs matches
    if (this.minimum_point_costs.value > 0 || this.maximum_point_costs.value < 20) {
      if (!((this.getPoints(card.data) >= this.minimum_point_costs.value && this.getPoints(card.data) <= this.maximum_point_costs.value) || (card.data.variablepoints != null))) {
        return false;
      }
      if (card.data.variablepoints != null) {
        matching_points = false;
        variablepoints = this.getPoints(card.data);
        if (Array.isArray(variablepoints)) {
          for (k1 = 0, len9 = variablepoints.length; k1 < len9; k1++) {
            points = variablepoints[k1];
            if (points >= this.minimum_point_costs.value && points <= this.maximum_point_costs.value) {
              matching_points = true;
              break;
            }
          }
          if (!matching_points) {
            return false;
          }
        }
      }
      if (card.orig_type === 'Ship') { // check if pilot matching points exist
        matching_points = false;
        for (l1 = 0, len10 = selected_factions.length; l1 < len10; l1++) {
          faction = selected_factions[l1];
          ref15 = exportObj.pilotsByFactionCanonicalName[faction];
          for (name in ref15) {
            pilots = ref15[name];
            for (m1 = 0, len11 = pilots.length; m1 < len11; m1++) {
              pilot = pilots[m1];
              if (pilot.ship === card.data.name) {
                if (this.getPoints(pilot) >= this.minimum_point_costs.value && this.getPoints(pilot) <= this.maximum_point_costs.value) {
                  matching_points = true;
                  break;
                }
              }
            }
            if (matching_points) {
              break;
            }
          }
          if (matching_points) {
            break;
          }
        }
        if (!matching_points) {
          return false;
        }
      }
    }
    // check if loadout costs matches
    if (this.minimum_loadout_costs.value > 0 || this.maximum_loadout_costs.value < 99) {
      if (!(this.getLoadout(card.data) >= this.minimum_loadout_costs.value && this.getLoadout(card.data) <= this.maximum_loadout_costs.value)) {
        return false;
      }
      if (card.orig_type === 'Ship') { // check if pilot matching points exist
        matching_loadout = false;
        for (n1 = 0, len12 = selected_factions.length; n1 < len12; n1++) {
          faction = selected_factions[n1];
          ref16 = exportObj.pilotsByFactionCanonicalName[faction];
          for (name in ref16) {
            pilots = ref16[name];
            for (o1 = 0, len13 = pilots.length; o1 < len13; o1++) {
              pilot = pilots[o1];
              if (pilot.ship === card.data.name) {
                if (this.getLoadout(pilot) >= this.minimum_loadout_costs.value && this.getLoadout(pilot) <= this.maximum_loadout_costs.value) {
                  matching_loadout = true;
                  break;
                }
              }
            }
            if (matching_loadout) {
              break;
            }
          }
          if (matching_loadout) {
            break;
          }
        }
        if (!matching_loadout) {
          return false;
        }
      }
    }
    // check if used slot matches
    used_slots = this.searchInputs.used_slots;
    if (used_slots.length > 0) {
      if (card.data.slot == null) {
        return false;
      }
      matches = false;
      for (p1 = 0, len14 = used_slots.length; p1 < len14; p1++) {
        slot = used_slots[p1];
        if (card.data.slot === slot) {
          matches = true;
          break;
        }
      }
      if (!matches) {
        return false;
      }
    }
    // check if used second slot matchesexportObj.builders[7]
    used_second_slots = this.searchInputs.used_second_slots;
    if (used_second_slots.length > 0) {
      if (card.data.also_occupies_upgrades == null) {
        return false;
      }
      matches = false;
      for (q1 = 0, len15 = used_second_slots.length; q1 < len15; q1++) {
        slot = used_second_slots[q1];
        ref17 = card.data.also_occupies_upgrades;
        for (r1 = 0, len16 = ref17.length; r1 < len16; r1++) {
          adds = ref17[r1];
          if (adds === slot) {
            matches = true;
            break;
          }
        }
      }
      if (!matches) {
        return false;
      }
    }
    if ((card.data.also_occupies_upgrades == null) && this.hassecondslot.checked) {
      // check if has a second slot
      return false;
    }
    if (!(!this.unique_checkbox.checked || card.data.unique)) {
      
      // check for uniqueness
      return false;
    }
    if (!(!this.non_unique_checkbox.checked || !card.data.unique)) {
      return false;
    }
    if (!(!this.limited_checkbox.checked || card.data.max_per_squad)) {
      return false;
    }
    if (!(((card.data.charge != null) && card.data.charge <= this.maximum_charge.value && card.data.charge >= this.minimum_charge.value) || (this.minimum_charge.value <= 0 && (card.data.charge == null)))) {
      
      // check charge stuff
      return false;
    }
    if (card.data.recurring && !this.recurring_charge.checked) {
      return false;
    }
    if (card.data.charge && !card.data.recurring && !this.not_recurring_charge.checked) {
      return false;
    }
    // check collection status
    if (((ref18 = exportObj.builders[7].collection) != null ? ref18.counts : void 0) != null) {
      owned_copies = this.getCollectionNumber(card);
      if (!(owned_copies >= this.minimum_owned_copies.value && owned_copies <= this.maximum_owned_copies.value)) {
        return false;
      } // ignore collection stuff, if no collection available
    }
    // check for ini
    if (card.data.skill != null) {
      if (!(card.data.skill >= this.minimum_ini.value && card.data.skill <= this.maximum_ini.value)) {
        return false;
      }
    } else {
      if (!(this.minimum_ini.value <= 0 && this.maximum_ini.value >= 6)) {
        
        // if the card has no ini value (is not a pilot) return false, if the ini criteria has been set (is not 0 to 6)
        return false;
      }
    }
    // check for base size
    if (!(this.base_size_checkboxes['Small'].checked && this.base_size_checkboxes['Medium'].checked && this.base_size_checkboxes['Large'].checked && this.base_size_checkboxes['Huge'].checked)) {
      size_matches = false;
      if (card.orig_type === 'Ship') {
        if (card.data.base != null) {
          size_matches = size_matches || this.base_size_checkboxes[card.data.base].checked;
        } else {
          size_matches = size_matches || this.base_size_checkboxes['Small'].checked;
        }
      } else if (card.orig_type === 'Pilot') {
        ship = exportObj.ships[card.data.ship];
        if (ship.base != null) {
          size_matches = size_matches || this.base_size_checkboxes[ship.base].checked;
        } else {
          size_matches = size_matches || this.base_size_checkboxes['Small'].checked;
        }
      }
      if (!size_matches) {
        return false;
      }
    }
    // check for hull
    if (this.minimum_hull.value !== "0" || this.maximum_hull.value !== "12") {
      if (!(((card.data.hull != null) && card.data.hull >= this.minimum_hull.value && card.data.hull <= this.maximum_hull.value) || (card.orig_type === 'Pilot' && exportObj.ships[card.data.ship].hull >= this.minimum_hull.value && exportObj.ships[card.data.ship].hull <= this.maximum_hull.value))) {
        return false;
      }
    }
    
    // check for shields
    if (this.minimum_shields.value !== "0" || this.maximum_shields.value !== "6") {
      if (!(((card.data.shields != null) && card.data.shields >= this.minimum_shields.value && card.data.shields <= this.maximum_shields.value) || (card.orig_type === 'Pilot' && exportObj.ships[card.data.ship].shields >= this.minimum_shields.value && exportObj.ships[card.data.ship].shields <= this.maximum_shields.value))) {
        return false;
      }
    }
    
    // check for agility
    if (this.minimum_agility.value !== "0" || this.maximum_agility.value !== "3") {
      if (!(((card.data.agility != null) && card.data.agility >= this.minimum_agility.value && card.data.agility <= this.maximum_agility.value) || (card.orig_type === 'Pilot' && exportObj.ships[card.data.ship].agility >= this.minimum_agility.value && exportObj.ships[card.data.ship].agility <= this.maximum_agility.value))) {
        return false;
      }
    }
    
    // check for attack
    if (this.minimum_attack.value !== "0" || this.maximum_attack.value !== "5") {
      if (!(((card.data.attack != null) && card.data.attack >= this.minimum_attack.value && card.data.attack <= this.maximum_attack.value) || (card.orig_type === 'Pilot' && (((exportObj.ships[card.data.ship].attack != null) && exportObj.ships[card.data.ship].attack >= this.minimum_attack.value && exportObj.ships[card.data.ship].attack <= this.maximum_attack.value) || ((exportObj.ships[card.data.ship].attack == null) && this.minimum_attack.value <= 0))) || (card.orig_type === 'Ship' && (card.data.attack == null) && this.minimum_attack.value <= 0))) {
        return false;
      }
    }
    
    // check for attackt
    if (this.minimum_attackt.value !== "0" || this.maximum_attackt.value !== "5") {
      if (!(((card.data.attackt != null) && card.data.attackt >= this.minimum_attackt.value && card.data.attackt <= this.maximum_attackt.value) || (card.orig_type === 'Pilot' && (((exportObj.ships[card.data.ship].attackt != null) && exportObj.ships[card.data.ship].attackt >= this.minimum_attackt.value && exportObj.ships[card.data.ship].attackt <= this.maximum_attackt.value) || ((exportObj.ships[card.data.ship].attackt == null) && this.minimum_attackt.value <= 0))) || (card.orig_type === 'Ship' && (card.data.attackt == null) && this.minimum_attackt.value <= 0))) {
        return false;
      }
    }
    
    // check for attackdt
    if (this.minimum_attackdt.value !== "0" || this.maximum_attackdt.value !== "5") {
      if (!(((card.data.attackdt != null) && card.data.attackdt >= this.minimum_attackdt.value && card.data.attackdt <= this.maximum_attackdt.value) || (card.orig_type === 'Pilot' && (((exportObj.ships[card.data.ship].attackdt != null) && exportObj.ships[card.data.ship].attackdt >= this.minimum_attackdt.value && exportObj.ships[card.data.ship].attackdt <= this.maximum_attackdt.value) || ((exportObj.ships[card.data.ship].attackdt == null) && this.minimum_attackdt.value <= 0))) || (card.orig_type === 'Ship' && (card.data.attackdt == null) && this.minimum_attackdt.value <= 0))) {
        return false;
      }
    }
    
    // check for attackf
    if (this.minimum_attackf.value !== "0" || this.maximum_attackf.value !== "5") {
      if (!(((card.data.attackf != null) && card.data.attackf >= this.minimum_attackf.value && card.data.attackf <= this.maximum_attackf.value) || (card.orig_type === 'Pilot' && (((exportObj.ships[card.data.ship].attackf != null) && exportObj.ships[card.data.ship].attackf >= this.minimum_attackf.value && exportObj.ships[card.data.ship].attackf <= this.maximum_attackf.value) || ((exportObj.ships[card.data.ship].attackf == null) && this.minimum_attackf.value <= 0))) || (card.orig_type === 'Ship' && (card.data.attackf == null) && this.minimum_attackf.value <= 0))) {
        return false;
      }
    }
    
    // check for attackb
    if (this.minimum_attackb.value !== "0" || this.maximum_attackb.value !== "5") {
      if (!(((card.data.attackb != null) && card.data.attackb >= this.minimum_attackb.value && card.data.attackb <= this.maximum_attackb.value) || (card.orig_type === 'Pilot' && (((exportObj.ships[card.data.ship].attackb != null) && exportObj.ships[card.data.ship].attackb >= this.minimum_attackb.value && exportObj.ships[card.data.ship].attackb <= this.maximum_attackb.value) || ((exportObj.ships[card.data.ship].attackb == null) && this.minimum_attackb.value <= 0))) || (card.orig_type === 'Ship' && (card.data.attackb == null) && this.minimum_attackb.value <= 0))) {
        return false;
      }
    }
    
    // check for attackbull
    if (this.minimum_attackbull.value !== "0" || this.maximum_attackbull.value !== "5") {
      if (!(((card.data.attackbull != null) && card.data.attackbull >= this.minimum_attackbull.value && card.data.attackbull <= this.maximum_attackbull.value) || (card.orig_type === 'Pilot' && (((exportObj.ships[card.data.ship].attackbull != null) && exportObj.ships[card.data.ship].attackbull >= this.minimum_attackbull.value && exportObj.ships[card.data.ship].attackbull <= this.maximum_attackbull.value) || ((exportObj.ships[card.data.ship].attackbull == null) && this.minimum_attackbull.value <= 0))) || (card.orig_type === 'Ship' && (card.data.attackbull == null) && this.minimum_attackbull.value <= 0))) {
        return false;
      }
    }
    
    // check for force
    if (this.minimum_force.value !== "0" || this.maximum_force.value !== "3") {
      if (!(((card.data.force != null) && card.data.force >= this.minimum_force.value && card.data.force <= this.maximum_force.value) || (card.orig_type === 'Pilot' && exportObj.ships[card.data.ship].force >= this.minimum_force.value && exportObj.ships[card.data.ship].force <= this.maximum_force.value) || ((card.data.force == null) && this.minimum_force.value === "0"))) {
        return false;
      }
    }
    
    //TODO: Add logic of addiditional search criteria here. Have a look at card.data, to see what data is available. Add search inputs at the todo marks above. 
    return true;
  }

};

/*
    X-Wing Rules Browser
    Stephen Kim <raithos@gmail.com>
    https://github.com/raithos/xwing
*/
exportObj = typeof exports !== "undefined" && exports !== null ? exports : this;

// Assumes cards.js has been loaded
exportObj.RulesBrowser = class RulesBrowser {
  constructor(args) {
    var ref;
    // args
    this.container = $(args.container);
    // internals
    this.language = (ref = exportObj.currentLanguage) != null ? ref : 'English';
    this.prepareRulesData();
    this.setupRuleUI();
    this.setupRulesHandlers();
  }

  setupRuleUI() {
    var date, version;
    this.container.append($.trim(`<div class="container-fluid xwing-rules-browser">
    <div class="row">
        <div class="col-md-4">
            <div class="card card-search-container">
                <h5 class="card-title translated" defaultText="Rules Search"></h5>
                <div class="advanced-search-container">
                    <h6 class="card-subtitle mb-2 text-muted version"><span class="translated" defaultText="Version"></span>: </h6>
                    <label class = "text-search advanced-search-label">
                        <strong class="translated" defaultText="Term:"></strong>
                        <input type="search" placeholder="${exportObj.translate('ui', "Search for game term or card")}" class = "rule-search-text">
                    </label>
                </div>
                <div class="rules-container card-selector-container">
                </div>
            </div>
        </div>
        <div class="col-md-8">
            <div class="card card-viewer-container card-search-container">
                <h4 class="card-title info-name"></h4>
                <br />
                <p class="info-text" />
            </div>
        </div>
    </div>
</div>`));
    this.versionlabel = $(this.container.find('.xwing-rules-browser .version'));
    this.rule_selector_container = $(this.container.find('.xwing-rules-browser .rules-container'));
    this.rule_viewer_container = $(this.container.find('.xwing-rules-browser .card-viewer-container'));
    this.rule_viewer_container.hide();
    this.advanced_search_container = $(this.container.find('.xwing-rules-browser .advanced-search-container'));
    exportObj.translateUIElements(this.container);
    // TODO: Make added inputs easy accessible
    version = this.all_rules.version.number;
    date = this.all_rules.version.date;
    this.versionlabel.append(`${version}, ${date}`);
    return this.rule_search_rules_text = ($(this.container.find('.xwing-rules-browser .rule-search-text')))[0];
  }

  setupRulesHandlers() {
    this.renderRulesList();
    $(window).on('xwing:afterLanguageLoad', (e, language, cb = $.noop) => {
      this.language = language;
      exportObj.loadRules(language);
      this.prepareRulesData();
      return this.renderRulesList();
    });
    return this.rule_search_rules_text.oninput = () => {
      return this.renderRulesList();
    };
  }

  prepareRulesData() {
    this.all_rules = exportObj.rulesEntries();
    return this.ruletype = ['glossary', 'faq'];
  }

  renderRulesList() {
    var j, len, optgroup, ref, ref1, rule_added, rule_data, rule_name, type;
    if (this.rule_selector != null) {
      // sort_by is one of `name`, `type-by-name`, `source`, `type-by-points`

      // Renders multiselect to container
      // Selects previously selected rule if there is one
      this.rule_selector.remove();
    }
    this.rule_selector = $(document.createElement('SELECT'));
    this.rule_selector.addClass('card-selector');
    this.rule_selector.attr('size', 25);
    this.rule_selector_container.append(this.rule_selector);
    ref = this.ruletype;
    for (j = 0, len = ref.length; j < len; j++) {
      type = ref[j];
      optgroup = $(document.createElement('OPTGROUP'));
      optgroup.attr('label', exportObj.translate('rulestypes', type));
      rule_added = false;
      ref1 = this.all_rules[type];
      for (rule_name in ref1) {
        rule_data = ref1[rule_name];
        if (this.checkRulesSearchCriteria(rule_data)) {
          this.addRulesTo(optgroup, rule_data);
          rule_added = true;
        }
      }
      if (rule_added) {
        this.rule_selector.append(optgroup);
      }
    }
    return this.rule_selector.change((e) => {
      return this.renderRules($(this.rule_selector.find(':selected')));
    });
  }

  renderRules(rule) {
    var data, orig_type;
    // Renders rule to rule container
    data = {
      name: rule.data('name'),
      text: rule.data('text')
    };
    orig_type = 'Rules';
    this.rule_viewer_container.show();
    return exportObj.builders[0].showTooltip(orig_type, data, typeof add_opts !== "undefined" && add_opts !== null ? add_opts : {}, this.rule_viewer_container); // we use the render method from the squad builder, cause it works.
  }

  addRulesTo(container, rule) {
    var option;
    option = $(document.createElement('OPTION'));
    option.text(`${rule.name}`);
    option.data('name', rule.name);
    option.data('text', exportObj.fixIcons(rule));
    return $(container).append(option);
  }

  checkRulesSearchCriteria(rule) {
    var search_text, text_search;
    // check for text search
    search_text = this.rule_search_rules_text.value.toLowerCase();
    text_search = rule.name.toLowerCase().indexOf(search_text) > -1 || (rule.text && rule.text.toLowerCase().indexOf(search_text)) > -1;
    if (!text_search) {
      return false;
    }
    return true;
  }

};

DFL_LANGUAGE = 'English'; // default language

SHOW_DEBUG_OUT_MISSING_TRANSLATIONS = false;

builders = [];

exportObj = typeof exports !== "undefined" && exports !== null ? exports : this;

// TODO: create a reasonable scope for this (e.g. a translation class), so vars like currentLanguage
// and methods like translateToLang are not within exportObj scope

// a language change event will only affect the current language, if it has higher priority than 
// the current languagePriority.
// -1: default language
//  3: browser setting
//  5: default priority (should not be used by now)
//  8: parsed from html header (done in backend)
// 10: backend setting
// 100: manual selection
exportObj.languagePriority = -1;

try {
  // try to set the current language according to the users choice
  (function() {
    var j, langc, languageCodes, len, results1;
    // we'll guess language from browser settings - unless a better choice has already been made
    if (exportObj.languagePriority > 3) {
      return;
    }
    exportObj.currentLanguage = DFL_LANGUAGE;
    if (exportObj.languagePriority === -1) {
      return;
    }
    // some browses just provide a single navigator.language, some provide an array navigator.languages 
    languageCodes = [navigator.language].concat(navigator.languages);
    results1 = [];
    for (j = 0, len = languageCodes.length; j < len; j++) {
      langc = languageCodes[j];
      // strip stuff like -US from en-US
      langc = langc.split('-')[0];
      if (langc in exportObj.codeToLanguage) {
        // assume that exportObj already exists. If it does not, we don't know which languages YASB supports
        exportObj.currentLanguage = exportObj.codeToLanguage[langc];
        // we successfully found a language the user is somewhat happy with. that's cool
        exportObj.languagePriority = 3;
        break;
      } else {
        results1.push(void 0);
      }
    }
    return results1;
  })();
} catch (error1) {
  all = error1;
  exportObj.currentLanguage = DFL_LANGUAGE;
}

// throw all
exportObj.loadCards = function(language) {
  return exportObj.cardLoaders[language]();
};

exportObj.loadRules = function(language) {
  // console.log("Loading rules:")
  // console.log(language)
  if (language in exportObj.ruleLoaders) {
    // console.log("Rules exist")
    if (exportObj.rulesLang !== language) {
      // console.log("Not already active, currently was")
      // console.log(exportObj.rulesLang)
      exportObj.ruleLoaders[language]();
      exportObj.rulesLang = language;
    }
    return true;
  } else {
    // console.log("Load default instead")
    if (exportObj.rulesLang !== DFL_LANGUAGE) {
      // console.log("Not already active")
      exportObj.ruleLoaders[DFL_LANGUAGE]();
      exportObj.rulesLang = DFL_LANGUAGE;
    }
    return false;
  }
};

exportObj.translate = function(category, what, ...args) {
  return exportObj.translateToLang(exportObj.currentLanguage, category, what, ...args);
};

// this method should be somewhat private, and not be called outside this file
exportObj.translateToLang = function(language, category, what, ...args) {
  var translation;
  try {
    translation = exportObj.translations[language][category][what];
  } catch (error1) {
    all = error1;
    // well, guess something went wrong - most likely some translation did not exist in the
    // current language. If that isn't the default language, we'll try that next in belows else block
    // otherwise we just use whatever is the in-code text of the requested translation.
    // Anyway, we want to keep running, so better catch that exception and keep going...
    translation = void 0;
  }
  if (translation != null) {
    if (translation instanceof Function) {
      // pass this function in case we need to do further translation inside the function
      return translation(exportObj.translate, ...args);
    } else {
      return translation;
    }
  } else {
    if (language !== DFL_LANGUAGE) {
      if (SHOW_DEBUG_OUT_MISSING_TRANSLATIONS) {
        console.log(language + ' translation for ' + String(what) + ' (category ' + String(category) + ') missing');
      }
      return exportObj.translateToLang(DFL_LANGUAGE, category, what, ...args);
    } else {
      return what;
    }
  }
};

exportObj.setupTranslationSupport = function() {
  var basic_cards, quick_builds;
  (function(builders) {
    return $(exportObj).on('xwing:languageChanged', async(e, language, priority = 5, cb = $.noop) => {
      var builder, builders_before, current_language, j, l, len, len1, results1;
      // check if priority is high enough to do anything
      if (priority === 'reload') { // special case - just a reload, no priority change
        null;
      // check if a better choice than the requested one has already been made
      } else if (priority < exportObj.languagePriority) {
        return;
      } else {
        exportObj.languagePriority = priority;
        exportObj.currentLanguage = language;
      }
      if (language in exportObj.translations) {
        $('.language-placeholder').text(language);
        current_language = "";
        builders_before = [];
        for (j = 0, len = builders.length; j < len; j++) {
          builder = builders[j];
          current_language = builder.language;
          builders_before.push(new Promise((resolve, reject) => {
            return builder.container.trigger('xwing:beforeLanguageLoad', resolve);
          }));
        }
        await Promise.all(builders_before);
        if (language !== current_language) {
          exportObj.loadCards(language);
        }
        exportObj.translateUIElements();
        results1 = [];
        for (l = 0, len1 = builders.length; l < len1; l++) {
          builder = builders[l];
          results1.push(builder.container.trigger('xwing:afterLanguageLoad', language));
        }
        return results1;
      }
    });
  })(builders);
  // Load cards one time
  basic_cards = exportObj.basicCardData();
  quick_builds = exportObj.basicQuickBuilds();
  exportObj.canonicalizeShipNames(basic_cards);
  exportObj.ships = basic_cards.ships;
  // Set up the common card data (e.g. stats)
  exportObj.setupCommonCardData(basic_cards);
  exportObj.setupQuickBuilds(quick_builds);
  // do we need to load dfl as well? Not sure...
  exportObj.loadCards(DFL_LANGUAGE);
  exportObj.loadRules(exportObj.currentLanguage);
  if (DFL_LANGUAGE !== exportObj.currentLanguage) {
    exportObj.loadCards(exportObj.currentLanguage);
  }
  return $(exportObj).trigger('xwing:languageChanged', [exportObj.currentLanguage, 'reload']);
};

exportObj.translateUIElements = function(context = void 0) {
  var j, len, ref, results1, translateableNode;
  ref = $('.translated', context);
  // translate all UI elements that are marked as translateable
  results1 = [];
  for (j = 0, len = ref.length; j < len; j++) {
    translateableNode = ref[j];
    results1.push(translateableNode.innerHTML = exportObj.translate('ui', translateableNode.getAttribute('defaultText')));
  }
  return results1;
};

exportObj.setupTranslationUI = function(backend) {
  var j, language, len, li, ref, results1;
  ref = Object.keys(exportObj.cardLoaders).sort();
  results1 = [];
  for (j = 0, len = ref.length; j < len; j++) {
    language = ref[j];
    li = $(document.createElement('LI'));
    li.text(language);
    (function(language, backend) {
      return li.click(function(e) {
        if (backend != null) {
          backend.set('language', language);
        }
        // setting a language manually has pretty high priority
        return $(exportObj).trigger('xwing:languageChanged', [language, 100]);
      });
    })(language, backend);
    results1.push($('.language-picker .dropdown-menu').append(li));
  }
  return results1;
};

exportObj.registerBuilderForTranslation = function(builder) {
  if (indexOf.call(builders, builder) < 0) {
    return builders.push(builder);
  }
};

/*
    X-Wing Squad Builder 2.5
    Stephen Kim <raithos@gmail.com>
    https://yasb.app
*/
exportObj = typeof exports !== "undefined" && exports !== null ? exports : this;

exportObj.sortHelper = function(a, b) {
  var a_name, b_name;
  if (a.points === b.points) {
    a_name = a.text.replace(/[^a-z0-9]/ig, '');
    b_name = b.text.replace(/[^a-z0-9]/ig, '');
    if (a_name === b_name) {
      return 0;
    } else {
      if (a_name > b_name) {
        return 1;
      } else {
        return -1;
      }
    }
  } else if (typeof a.points === "string") { // handling cases where points value is "*" instead of a number
    return 1;
  } else {
    if (a.points > b.points) {
      return 1;
    } else {
      return -1;
    }
  }
};

exportObj.toTTS = function(txt) {
  if (txt == null) {
    return null;
  } else {
    return txt.replace(/\(.*\)/g, "").replace("�", '"').replace("�", '"');
  }
};

exportObj.slotsMatching = function(slota, slotb) {
  if (slota === slotb) {
    return true;
  }
  switch (slota) {
    case 'HardpointShip':
      if (slotb === 'Torpedo' || slotb === 'Cannon' || slotb === 'Missile') {
        return true;
      }
      break;
    case 'VersatileShip':
      if (slotb === 'Torpedo' || slotb === 'Missile') {
        return true;
      }
  }
  switch (slotb) {
    case 'HardpointShip':
      if (slota === 'Torpedo' || slota === 'Cannon' || slota === 'Missile') {
        return true;
      }
      break;
    case 'VersatileShip':
      if (slota === 'Torpedo' || slota === 'Missile') {
        return true;
      }
  }
  return false;
};

$.isMobile = function() {
  if ((navigator.userAgent.match(/(iPhone|iPod|iPad|Android)/i)) || navigator.maxTouchPoints > 1) {
    return true;
  }
  return false;
};

$.randomInt = function(n) {
  return Math.floor(Math.random() * n);
};

$.isElementInView = function(element, fullyInView) {
  var elementBottom, elementTop, pageBottom, pageTop, ref, ref1;
  pageTop = $(window).scrollTop();
  pageBottom = pageTop + $(window).height();
  elementTop = (ref = $(element)) != null ? (ref1 = ref.offset()) != null ? ref1.top : void 0 : void 0;
  elementBottom = elementTop + $(element).height();
  if (fullyInView) {
    return (pageTop < elementTop) && (pageBottom > elementBottom);
  } else {
    return (elementTop <= pageBottom) && (elementBottom >= pageTop);
  }
};

// ripped from http://stackoverflow.com/questions/901115/how-can-i-get-query-string-values
$.getParameterByName = function(name) {
  var regex, regexS, results;
  name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
  regexS = "[\\?&]" + name + "=([^&#]*)";
  regex = new RegExp(regexS);
  results = regex.exec(window.location.search);
  if (results === null) {
    return "";
  } else {
    return decodeURIComponent(results[1].replace(/\+/g, " "));
  }
};

Array.prototype.intersects = function(other) {
  var item, j, len, ref;
  ref = this;
  for (j = 0, len = ref.length; j < len; j++) {
    item = ref[j];
    if (indexOf.call(other, item) >= 0) {
      return true;
    }
  }
  return false;
};

Array.prototype.removeItem = function(item) {
  var idx;
  idx = this.indexOf(item);
  if (idx !== -1) {
    this.splice(idx, 1);
  }
  return this;
};

String.prototype.capitalize = function() {
  return this.charAt(0).toUpperCase() + this.slice(1);
};

String.prototype.getXWSBaseName = function() {
  return this.split('-')[0];
};

URL_BASE = `${window.location.protocol}//${window.location.host}${window.location.pathname}`;

SQUAD_DISPLAY_NAME_MAX_LENGTH = 24;

statAndEffectiveStat = function(base_stat, effective_stats, key) {
  if (base_stat != null) {
    return `${base_stat}${((effective_stats != null) && (effective_stats[key] != null) && effective_stats[key] !== base_stat) ? ` (${effective_stats[key]})` : ""}`;
  } else if ((effective_stats != null) && (effective_stats[key] != null)) {
    return `0 (${effective_stats[key]})`;
  } else {
    return "0";
  }
};

getPrimaryFaction = function(faction) {
  switch (faction) {
    case 'Rebel Alliance':
      return 'Rebel Alliance';
    case 'Galactic Empire':
      return 'Galactic Empire';
    default:
      return faction;
  }
};

conditionToHTML = function(condition) {
  var html;
  return html = $.trim(`<div class="condition">
    <div class="name">${condition.unique ? "&middot;&nbsp;" : ""}${condition.display_name ? condition.display_name : condition.name}</div>
    <div class="text">${condition.text}</div>
</div>`);
};

exportObj.SquadBuilder = (function() {
  var dfl_filter_func;

  // Assumes cards.js will be loaded
  class SquadBuilder {
    constructor(args) {
      var ref, ref1, ref2, ref3, ref4, ref5, ref6, ref7, ref8, ref9;
      this.getPermaLinkParams = this.getPermaLinkParams.bind(this);
      this.getPermaLink = this.getPermaLink.bind(this);
      this.updateShipOrder = this.updateShipOrder.bind(this);
      this.updatePermaLink = this.updatePermaLink.bind(this);
      this.onNotesUpdated = this.onNotesUpdated.bind(this);
      this.onGameTypeChanged = this.onGameTypeChanged.bind(this);
      this.onPointsUpdated = this.onPointsUpdated.bind(this);
      this.onSquadLoadRequested = this.onSquadLoadRequested.bind(this);
      this.onSquadDirtinessChanged = this.onSquadDirtinessChanged.bind(this);
      this.onSquadNameChanged = this.onSquadNameChanged.bind(this);
      this.updatePrintAndExportTexts = this.updatePrintAndExportTexts.bind(this);
      this.claimUnique = this.claimUnique.bind(this);
      this.releaseUnique = this.releaseUnique.bind(this);
      this._randomizerLoopBody = this._randomizerLoopBody.bind(this);
      this._makeRandomizerLoopFunc = this._makeRandomizerLoopFunc.bind(this);
      // args
      this.container = $(args.container);
      this.faction = $.trim(args.faction);
      this.printable_container = $(args.printable_container);
      this.tab = $(args.tab);
      this.show_points_destroyed = false;
      this.isCurrentlyLoadingSquad = false;
      // internal state
      this.ships = [];
      this.uniques_in_use = {
        Pilot: [],
        Upgrade: [],
        Slot: []
      };
      this.standard_list = {
        Upgrade: [],
        Ship: []
      };
      this.suppress_automatic_new_ship = false;
      this.tooltip_currently_displaying = null;
      this.randomizer_options = {
        sources: null,
        points: 20,
        ship_limit: 0,
        collection_only: true,
        fill_zero_pts: false
      };
      this.total_points = 0;
      // a squad given in the link is loaded on construction of that builder. It will set all gamemodes of already existing builders accordingly, but we did not exists back than. So we copy over the gamemode
      this.isStandard = (ref = (ref1 = exportObj.builders[0]) != null ? ref1.isStandard : void 0) != null ? ref : false;
      this.isEpic = (ref2 = (ref3 = exportObj.builders[0]) != null ? ref3.isEpic : void 0) != null ? ref2 : false;
      this.isXwa = (ref4 = (ref5 = exportObj.builders[0]) != null ? ref5.isXwa : void 0) != null ? ref4 : true;
      this.isQuickbuild = (ref6 = (ref7 = exportObj.builders[0]) != null ? ref7.isQuickbuild : void 0) != null ? ref6 : false;
      this.backend = null;
      this.current_squad = {};
      // todo: remove? The translation file should take care of languge management. 
      this.language = (ref8 = exportObj.currentLanguage) != null ? ref8 : 'English';
      this.collection = null;
      this.current_obstacles = [];
      this.setupUI();
      if (this.faction === "All") {
        this.game_type_selector.val("epic").trigger('change');
      } else {
        this.game_type_selector.val(((ref9 = exportObj.builders[0]) != null ? ref9 : this).game_type_selector.val()).trigger('change');
      }
      this.setupEventHandlers();
      window.setInterval(this.updatePermaLink, 250);
      this.isUpdatingPoints = false;
      if ($.getParameterByName('f') === this.faction) {
        this.resetCurrentSquad(true);
        this.loadFromSerialized($.getParameterByName('d'));
      } else {
        this.resetCurrentSquad();
        this.addShip();
      }
    }

    resetCurrentSquad(initial_load = false) {
      var default_squad_name, squad_name, squad_obstacles;
      default_squad_name = this.uitranslation('Unnamed Squadron');
      squad_name = $.trim(this.squad_name_input.val()) || default_squad_name;
      if (initial_load && $.trim($.getParameterByName('sn'))) {
        squad_name = $.trim($.getParameterByName('sn'));
      }
      squad_obstacles = [];
      if (initial_load && $.trim($.getParameterByName('obs'))) {
        squad_obstacles = ($.trim($.getParameterByName('obs'))).split(",").slice(0, 3);
        this.updateObstacleSelect(squad_obstacles);
      } else if (this.current_obstacles) {
        squad_obstacles = this.current_obstacles;
      }
      this.current_squad = {
        id: null,
        name: squad_name,
        dirty: false,
        additional_data: {
          points: this.total_points,
          description: '',
          cards: [],
          notes: '',
          obstacles: squad_obstacles,
          tag: ''
        },
        faction: this.faction
      };
      if (this.total_points > 0) {
        if (squad_name === default_squad_name) {
          this.current_squad.name = this.uitranslation('Unsaved Squadron');
        }
        this.current_squad.dirty = true;
      }
      this.old_version_container.toggleClass('d-none', true);
      this.container.trigger('xwing-backend:squadNameChanged');
      return this.container.trigger('xwing-backend:squadDirtinessChanged');
    }

    newSquadFromScratch(squad_name = this.uitranslation('New Squadron')) {
      this.squad_name_input.val(squad_name);
      this.removeAllShips();
      if (!this.suppress_automatic_new_ship) {
        this.addShip();
      }
      this.updateObstacleSelect([]);
      this.resetCurrentSquad();
      this.notes.val('');
      return this.tag.val('');
    }

    uitranslation(what, ...args) {
      return exportObj.translate('ui', what, args);
    }

    setupUI() {
      var DEFAULT_RANDOMIZER_POINTS, DEFAULT_RANDOMIZER_SHIP_LIMIT, DEFAULT_RANDOMIZER_TIMEOUT_SEC, content_container, expansion, j, len, obstacleFormat, opt, ref;
      DEFAULT_RANDOMIZER_POINTS = 20;
      DEFAULT_RANDOMIZER_TIMEOUT_SEC = 4;
      DEFAULT_RANDOMIZER_SHIP_LIMIT = 0;
      this.status_container = $(document.createElement('DIV'));
      this.status_container.addClass('container-fluid');
      this.status_container.append($.trim(`<div class="row squad-name-and-points-row">
    <div class="col-md-3 squad-name-container">
        <div class="display-name">
            <span class="squad-name"></span>
            <i class="far fa-edit"></i>
        </div>
        <div class="input-append">
            <input type="text" maxlength="64" placeholder="${this.uitranslation("Name your squad...")}" />
            <button class="btn save"><i class="fa fa-pen-square"></i></button>
        </div>
        <br class="hide-on-mobile" />
        <select class="game-type-selector">
            <option value="xwa" class="translated" defaultText="XWA" selected="selected">${this.uitranslation("XWA")}</option>
            <option value="standard" class="translated" defaultText="Standard">${this.uitranslation("Standard")}</option>
            <option value="extended" class="translated" defaultText="Extended">${this.uitranslation("Extended")}</option>
            <option value="epic" class="translated" defaultText="Epic">${this.uitranslation("Epic")}</option>
            <option value="quickbuild" class="translated" defaultText="Quickbuild">${this.uitranslation("Standard")}</option>
        </select>
    </div>
    <div class="col-md-4 points-display-container">
        Points: <span class="total-points">0</span> / <input type="number" class="desired-points" value="20">
        <span class="points-remaining-container">(<span class="points-remaining"></span>&nbsp;left) <span class="points-destroyed red"></span></span>
        <span class="content-warning unreleased-content-used d-none"><br /><i class="fa fa-exclamation-circle"></i>&nbsp;<span class="translated" defaultText="Unreleased content warning"></span></span>
        <span class="content-warning loading-failed-container d-none"><br /><i class="fa fa-exclamation-circle"></i>&nbsp;<span class="translated" defaultText="Broken squad link warning"></span></span>
        <span class="content-warning old-version-container d-none"><br /><i class="fa fa-exclamation-circle"></i>&nbsp;<span class="translated" defaultText="This squad was created for an older version of X-Wing."></span></span>
        <span class="content-warning collection-invalid d-none"><br /><i class="fa fa-exclamation-circle"></i>&nbsp;<span class="translated" defaultText="Collection warning"></span></span>
        <span class="content-warning ship-number-invalid-container d-none"><br /><i class="fa fa-exclamation-circle"></i>&nbsp;<span class="translated" defaultText="Ship number warning"></span></span>
        <span class="content-warning multi-faction-warning-container d-none"><br /><i class="fa fa-exclamation-circle"></i>&nbsp;<span class="translated" defaultText="Multi-Faction warning"></span></span>
        <span class="content-warning epic-not-legal-container d-none"><br /><i class="fa fa-exclamation-circle"></i>&nbsp;<span class="translated" defaultText="Epic Unofficial"></span></span>
    </div>
    <div class="col-md-5 float-right button-container">
        <div class="btn-group float-right">

            <button class="btn btn-info view-as-text"><span class="d-none d-lg-block"><i class="fa fa-print"></i>&nbsp;<span class="translated" defaultText="Print/Export"></span></span><span class="d-lg-none"><i class="fa fa-print"></i></span></button>
            <a class="btn btn-primary d-none collection"><span class="d-none d-lg-block"><i class="fa fa-folder-open"></i> <span class="translated" defaultText="Your Collection"></span></span><span class="d-lg-none"><i class="fa fa-folder-open"></i></span></a>
            <!-- Randomize button is marked as danger, since it creates a new squad -->
            <button class="btn btn-danger randomize"><span class="d-none d-lg-block"><i class="fa fa-random"></i> <span class="translated" defaultText="Randomize!"></span></span><span class="d-lg-none"><i class="fa fa-random"></i></span></button>
            <button class="btn btn-danger dropdown-toggle" data-toggle="dropdown">
                <span class="caret"></span>
            </button>
             <ul class="dropdown-menu dropdown-menu-right">
                <li><a class="dropdown-item randomize-options translated" defaultText="Randomizer Options"></a></li>
                <li><a class="dropdown-item misc-settings translated" defaultText="Misc Settings"></a></li>
            </ul>
        </div>
    </div>
</div>

<div class="row squad-save-buttons">
    <div class="col-md-12 squad-save-buttons-container">
        <button class="show-authenticated btn btn-primary save-list"><i class="far fa-save"></i>&nbsp;<span class="translated" defaultText="Save"></span></button>
        <button class="show-authenticated btn btn-primary save-list-as"><i class="far fa-file"></i>&nbsp;<span class="translated" defaultText="Save As..."></span></button>
        <button class="show-authenticated btn btn-primary delete-list disabled"><i class="fa fa-trash"></i>&nbsp;<span class="translated" defaultText="Delete"></span></button>
        <button class="show-authenticated btn btn-info backend-list-my-squads show-authenticated"><i class="fa fa-download"></i>&nbsp;<span class = "translated" defaultText="Load Squad"></span></button>
        <button class="btn btn-info import-squad"><i class="fa fa-file-import"></i>&nbsp;<span class="translated" defaultText="Import"></span></button>
        <button class="btn btn-info show-points-destroyed"><i class="fas fa-bullseye"></i>&nbsp;<span class="show-points-destroyed-span translated" defaultText="${this.uitranslation("Show Points Destroyed")}"></span></button>                    
        <button class="btn btn-danger clear-squad"><i class="fa fa-plus-circle"></i>&nbsp;<span class="translated" defaultText="New Squad"></span></button>
        <span class="show-authenticated backend-status"></span>
    </div>
</div>`));
      this.container.append(this.status_container);
      this.xws_import_modal = $(document.createElement('DIV'));
      this.xws_import_modal.addClass('modal fade import-modal d-print-none');
      this.xws_import_modal.tabindex = "-1";
      this.xws_import_modal.role = "dialog";
      this.xws_import_modal.append($.trim(`<div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="translated" defaultText="XWS Import"></h3>
            <button type="button" class="close d-print-none" data-dismiss="modal" aria-hidden="true">&times;</button>
        </div>
        <div class="modal-body">
            <span class="translated" defaultText="XWS Import Dialog"></span>
            <div class="container-fluid">
                <textarea class="xws-content" placeholder='` + this.uitranslation("Paste XWS here") + `'></textarea>
            </div>
        </div>
        <div class="modal-footer d-print-none">
            <span class="xws-import-status"></span>&nbsp;
            <button class="btn btn-danger import-xws translated" defaultText="Import"></button>
        </div>
    </div>
</div>`));
      this.from_xws_button = this.container.find('button.import-squad');
      this.from_xws_button.click((e) => {
        e.preventDefault();
        this.xws_import_modal.find('.xws-import-status').text(' ');
        return this.xws_import_modal.modal('show');
      });
      this.load_xws_button = $(this.xws_import_modal.find('button.import-xws'));
      this.load_xws_button.click((e) => {
        e.preventDefault();
        return exportObj.loadXWSButton(this.xws_import_modal);
      });
      this.container.append(this.xws_import_modal);
      this.list_modal = $(document.createElement('DIV'));
      this.list_modal.addClass('modal fade text-list-modal');
      this.list_modal.tabindex = "-1";
      this.list_modal.role = "dialog";
      this.container.append(this.list_modal);
      this.list_modal.append($.trim(`<div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable" role="document">
    <div class="modal-content">
        <div class="modal-header">
            <div class="d-print-none">
                <h4 class="modal-title"><span class="squad-name"></span> <span class="total-points"></span></h4>
            </div>
            <div class="d-none d-print-block">
                <div class="fancy-header">
                    <div class="squad-name"></div>
                    <div class="squad-faction"></div>
                    <div class="mask">
                        <div class="outer-circle">
                            <div class="inner-circle">
                                <span class="total-points"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="fancy-under-header"></div>
            </div>
            <button type="button" class="close d-print-none" data-dismiss="modal" aria-hidden="true">&times;</button>
        </div>
        <div class="modal-body">
            <div class="fancy-list"></div>
            <div class="simple-list"></div>
            <div class="simplecopy-list">
                <span class="translated" defaultText="Copy below simple text"></span>
                <textarea></textarea><button class="btn btn-modal btn-copy translated" defaultText="Copy"></button>
            </div>
            <div class="reddit-list">
                <span class="translated" defaultText="Copy below markdown"></span>
                <textarea></textarea><button class="btn btn-modal btn-copy translated" defaultText="Copy"></button>
            </div>
            <div class="tts-list">
                <span class="translated" defaultText="Copy below TTS"></span>
                <textarea></textarea><button class="btn btn-modal btn-copy translated" defaultText="Copy"></button>
            </div>
            <div class="xws-list">
                <span class="translated" defaultText="Copy below XWS"></span>
                <div class="row full-row">
                    <div class="col d-inline-block d-none d-sm-block"><textarea></textarea><br /><button class="btn btn-modal btn-copy translated" defaultText="Copy"></button></div>
                    <div class="col d-inline-block d-none d-sm-block qrcode-container" id="xws-qrcode-container"></div>
                </div>
            </div>
        </div>
        <div class="container-fluid modal-footer d-print-none">
            <div class="row full-row">
                <div class="col d-inline-block d-none d-sm-block right-col">
                    <label class="color-skip-text-checkbox">
                        <span class="translated" defaultText="Skip Card Text"></span> <input type="checkbox" class="toggle-skip-text-print" />
                    </label><br />
                    <label class="horizontal-space-checkbox">
                        <span class="translated" defaultText="Space for Cards"></span> <input type="checkbox" class="toggle-horizontal-space" />
                    </label><br />
                    <label class="maneuver-print-checkbox">
                        <span class="translated" defaultText="Include Maneuvers Chart"></span> <input type="checkbox" class="toggle-maneuver-print" />
                    </label><br />
                    <label class="expanded-shield-hull-print-checkbox">
                        <span class="translated" defaultText="Expand Shield and Hull"></span> <input type="checkbox" class="toggle-expanded-shield-hull-print" />
                    </label>
                </div>
                <div class="col d-inline-block d-none d-sm-block right-col">
                    <label class="color-print-checkbox">
                        <span class="translated" defaultText="Print Color"></span> <input type="checkbox" class="toggle-color-print" checked="checked" />
                    </label><br />
                    <label class="qrcode-checkbox">
                        <span class="translated" defaultText="Include QR codes"></span> <input type="checkbox" class="toggle-juggler-qrcode" checked="checked" />
                    </label><br />
                    <label class="obstacles-checkbox">
                        <span class="translated" defaultText="Include Obstacle Choices"></span> <input type="checkbox" class="toggle-obstacles" checked="checked" />
                    </label>
                </div>
            </div>
            <div class="row btn-group list-display-mode">
                <button class="btn btn-modal select-simple-view translated" defaultText="Simple"></button>
                <button class="btn btn-modal select-fancy-view translated" defaultText="Fancy"></button>
                <button class="btn btn-modal select-simplecopy-view translated" defaultText="Text"></button>
                <button class="btn btn-modal select-reddit-view translated" defaultText="Reddit"></button>
                <button class="btn btn-modal select-tts-view d-none d-sm-block translated" defaultText="TTS"></button>
                <button class="btn btn-modal select-xws-view translated" defaultText="XWS"></button>
            </div>
            <div class="row btn-group list-display-mode">
                <button class="btn btn-modal copy-url translated" defaultText="Copy URL"></button>
                <button class="btn btn-modal print-list d-sm-block"><span class="d-none d-lg-block"><i class="fa fa-print"></i>&nbsp;<span class="translated" defaultText="Print"></span></span><span class="d-lg-none"><i class="fa fa-print"></i></span></button>
            </div>
        </div>
    </div>
</div>`));
      this.fancy_container = $(this.list_modal.find('.fancy-list'));
      this.fancy_total_points_container = $(this.list_modal.find('div.modal-header .total-points'));
      this.simple_container = $(this.list_modal.find('div.modal-body .simple-list'));
      this.reddit_container = $(this.list_modal.find('div.modal-body .reddit-list'));
      this.reddit_textarea = $(this.reddit_container.find('textarea'));
      this.reddit_textarea.attr('readonly', 'readonly');
      this.simplecopy_container = $(this.list_modal.find('div.modal-body .simplecopy-list'));
      this.simplecopy_textarea = $(this.simplecopy_container.find('textarea'));
      this.simplecopy_textarea.attr('readonly', 'readonly');
      this.tts_container = $(this.list_modal.find('div.modal-body .tts-list'));
      this.tts_textarea = $(this.tts_container.find('textarea'));
      this.tts_textarea.attr('readonly', 'readonly');
      this.xws_container = $(this.list_modal.find('div.modal-body .xws-list'));
      this.xws_textarea = $(this.xws_container.find('textarea'));
      this.xws_textarea.attr('readonly', 'readonly');
      this.toggle_vertical_space_container = $(this.list_modal.find('.horizontal-space-checkbox'));
      this.toggle_color_print_container = $(this.list_modal.find('.color-print-checkbox'));
      this.toggle_color_skip_text = $(this.list_modal.find('.color-skip-text-checkbox'));
      this.toggle_maneuver_dial_container = $(this.list_modal.find('.maneuver-print-checkbox'));
      this.toggle_expanded_shield_hull_container = $(this.list_modal.find('.expanded-shield-hull-print-checkbox'));
      this.toggle_qrcode_container = $(this.list_modal.find('.qrcode-checkbox'));
      this.toggle_obstacle_container = $(this.list_modal.find('.obstacles-checkbox'));
      this.btn_print_list = ($(this.list_modal.find('.print-list')))[0];
      this.btn_copy_url = $(this.list_modal.find('.copy-url'));
      this.btn_copy_url.click((e) => {
        this.success = window.navigator.clipboard.writeText(window.location.href);
        this.self = $(e.currentTarget);
        if (this.success) {
          this.self.addClass('btn-success');
          return setTimeout((() => {
            return this.self.removeClass('btn-success');
          }), 1000);
        }
      });
      if (!["fullscreen", "standalone", "minimal-ui"].some((displayMode) => {
        return window.matchMedia('(display-mode: ' + displayMode + ')').matches;
      })) {
        
        // the url copy button is only needed if the browser is hiding the address bar. This is the case for PWA links. 
        this.btn_copy_url.hide();
      }
      this.list_modal.on('click', 'button.btn-copy', (e) => {
        this.self = $(e.currentTarget);
        this.self.siblings('textarea').select();
        this.success = document.execCommand('copy');
        if (this.success) {
          this.self.addClass('btn-success');
          return setTimeout((() => {
            return this.self.removeClass('btn-success');
          }), 1000);
        }
      });
      this.select_simple_view_button = $(this.list_modal.find('.select-simple-view'));
      this.select_simple_view_button.click((e) => {
        this.select_simple_view_button.blur();
        if (this.list_display_mode !== 'simple') {
          this.list_modal.find('.list-display-mode .btn').removeClass('btn-inverse');
          this.select_simple_view_button.addClass('btn-inverse');
          this.list_display_mode = 'simple';
          this.simple_container.show();
          this.fancy_container.hide();
          this.simplecopy_container.hide();
          this.reddit_container.hide();
          this.tts_container.hide();
          this.xws_container.hide();
          this.toggle_vertical_space_container.hide();
          this.toggle_color_print_container.hide();
          this.toggle_color_skip_text.hide();
          this.toggle_maneuver_dial_container.hide();
          this.toggle_expanded_shield_hull_container.hide();
          this.toggle_qrcode_container.show();
          this.toggle_obstacle_container.show();
          return this.btn_print_list.disabled = false;
        }
      });
      this.select_fancy_view_button = $(this.list_modal.find('.select-fancy-view'));
      this.select_fancy_view_button.click((e) => {
        this.select_fancy_view_button.blur();
        if (this.list_display_mode !== 'fancy') {
          this.list_modal.find('.list-display-mode .btn').removeClass('btn-inverse');
          this.select_fancy_view_button.addClass('btn-inverse');
          this.list_display_mode = 'fancy';
          this.fancy_container.show();
          this.simple_container.hide();
          this.simplecopy_container.hide();
          this.reddit_container.hide();
          this.tts_container.hide();
          this.xws_container.hide();
          this.toggle_vertical_space_container.show();
          this.toggle_color_print_container.show();
          this.toggle_color_skip_text.show();
          this.toggle_maneuver_dial_container.show();
          this.toggle_expanded_shield_hull_container.show();
          this.toggle_qrcode_container.show();
          this.toggle_obstacle_container.show();
          return this.btn_print_list.disabled = false;
        }
      });
      this.select_reddit_view_button = $(this.list_modal.find('.select-reddit-view'));
      this.select_reddit_view_button.click((e) => {
        this.select_reddit_view_button.blur();
        if (this.list_display_mode !== 'reddit') {
          this.list_modal.find('.list-display-mode .btn').removeClass('btn-inverse');
          this.select_reddit_view_button.addClass('btn-inverse');
          this.list_display_mode = 'reddit';
          this.reddit_container.show();
          this.simplecopy_container.hide();
          this.tts_container.hide();
          this.xws_container.hide();
          this.simple_container.hide();
          this.fancy_container.hide();
          this.reddit_textarea.select();
          this.reddit_textarea.focus();
          this.toggle_vertical_space_container.hide();
          this.toggle_color_print_container.hide();
          this.toggle_color_skip_text.hide();
          this.toggle_maneuver_dial_container.hide();
          this.toggle_expanded_shield_hull_container.hide();
          this.toggle_qrcode_container.hide();
          this.toggle_obstacle_container.hide();
          return this.btn_print_list.disabled = true;
        }
      });
      this.select_simplecopy_view_button = $(this.list_modal.find('.select-simplecopy-view'));
      this.select_simplecopy_view_button.click((e) => {
        this.select_simplecopy_view_button.blur();
        if (this.list_display_mode !== 'simplecopy') {
          this.list_modal.find('.list-display-mode .btn').removeClass('btn-inverse');
          this.select_simplecopy_view_button.addClass('btn-inverse');
          this.list_display_mode = 'simplecopy';
          this.reddit_container.hide();
          this.simplecopy_container.show();
          this.tts_container.hide();
          this.xws_container.hide();
          this.simple_container.hide();
          this.fancy_container.hide();
          this.simplecopy_textarea.select();
          this.simplecopy_textarea.focus();
          this.toggle_vertical_space_container.hide();
          this.toggle_color_print_container.hide();
          this.toggle_color_skip_text.hide();
          this.toggle_maneuver_dial_container.hide();
          this.toggle_expanded_shield_hull_container.hide();
          this.toggle_qrcode_container.hide();
          this.toggle_obstacle_container.hide();
          return this.btn_print_list.disabled = true;
        }
      });
      this.select_tts_view_button = $(this.list_modal.find('.select-tts-view'));
      this.select_tts_view_button.click((e) => {
        this.select_tts_view_button.blur();
        if (this.list_display_mode !== 'tts') {
          this.list_modal.find('.list-display-mode .btn').removeClass('btn-inverse');
          this.select_tts_view_button.addClass('btn-inverse');
          this.list_display_mode = 'tts';
          this.tts_container.show();
          this.xws_container.hide();
          this.simple_container.hide();
          this.simplecopy_container.hide();
          this.reddit_container.hide();
          this.fancy_container.hide();
          this.tts_textarea.select();
          this.tts_textarea.focus();
          this.toggle_vertical_space_container.hide();
          this.toggle_color_print_container.hide();
          this.toggle_color_skip_text.hide();
          this.toggle_maneuver_dial_container.hide();
          this.toggle_expanded_shield_hull_container.hide();
          this.toggle_qrcode_container.hide();
          this.toggle_obstacle_container.hide();
          return this.btn_print_list.disabled = true;
        }
      });
      this.select_xws_view_button = $(this.list_modal.find('.select-xws-view'));
      this.select_xws_view_button.click((e) => {
        return this.select_xws_view();
      });
      if ($(window).width() >= 768) {
        this.simple_container.hide();
        this.select_fancy_view_button.click();
      } else {
        this.select_simple_view_button.click();
      }
      this.clear_squad_button = $(this.status_container.find('.clear-squad'));
      this.clear_squad_button.click((e) => {
        if (this.current_squad.dirty && (this.backend != null)) {
          return this.backend.warnUnsaved(this, () => {
            return this.newSquadFromScratch();
          });
        } else {
          return this.newSquadFromScratch();
        }
      });
      this.show_points_destroyed_button = $(this.status_container.find('.show-points-destroyed'));
      this.show_points_destroyed_button_span = $(this.status_container.find('.show-points-destroyed-span'));
      this.show_points_destroyed_button.click((e) => {
        var j, len, ref, results1, ship;
        this.show_points_destroyed = !this.show_points_destroyed;
        if (this.show_points_destroyed === false) {
          this.points_destroyed_span.hide();
        } else {
          this.points_destroyed_span.show();
        }
        ref = this.ships;
        results1 = [];
        for (j = 0, len = ref.length; j < len; j++) {
          ship = ref[j];
          if (ship.pilot != null) {
            if (this.show_points_destroyed === false) {
              this.show_points_destroyed_button_span.text(this.uitranslation("Show Points Destroyed"));
              results1.push(ship.points_destroyed_button.hide());
            } else {
              this.show_points_destroyed_button_span.text(this.uitranslation("Hide Points Destroyed"));
              results1.push(ship.points_destroyed_button.show());
            }
          } else {
            results1.push(void 0);
          }
        }
        return results1;
      });
      this.squad_name_container = $(this.status_container.find('div.squad-name-container'));
      this.squad_name_display = $(this.container.find('.display-name'));
      this.squad_name_placeholder = $(this.container.find('.squad-name'));
      this.squad_name_input = $(this.squad_name_container.find('input'));
      this.squad_name_save_button = $(this.squad_name_container.find('button.save'));
      this.squad_name_input.closest('div').hide();
      this.points_container = $(this.status_container.find('div.points-display-container'));
      this.total_points_span = $(this.points_container.find('.total-points'));
      this.game_type_selector = $(this.status_container.find('.game-type-selector'));
      this.game_type_selector.select2({
        minimumResultsForSearch: -1
      });
      this.game_type_selector.change((e) => {
        // $(window).trigger 'xwing:gameTypeChanged', @game_type_selector.val()
        return this.onGameTypeChanged(this.game_type_selector.val());
      });
      this.desired_points_input = $(this.points_container.find('.desired-points'));
      this.desired_points_input.change((e) => {
        return this.container.trigger('xwing:pointsUpdated');
      });
      this.points_remaining_span = $(this.points_container.find('.points-remaining'));
      this.points_destroyed_span = $(this.points_container.find('.points-destroyed'));
      this.points_remaining_container = $(this.points_container.find('.points-remaining-container'));
      this.unreleased_content_used_container = $(this.points_container.find('.unreleased-content-used'));
      this.loading_failed_container = $(this.points_container.find('.loading-failed-container'));
      this.old_version_container = $(this.points_container.find('.old-version-container'));
      this.ship_number_invalid_container = $(this.points_container.find('.ship-number-invalid-container'));
      this.multi_faction_warning_container = $(this.points_container.find('.multi-faction-warning-container'));
      this.epic_not_legal_container = $(this.points_container.find('.epic-not-legal-container'));
      this.collection_invalid_container = $(this.points_container.find('.collection-invalid'));
      this.view_list_button = $(this.status_container.find('div.button-container button.view-as-text'));
      this.randomize_button = $(this.status_container.find('div.button-container button.randomize'));
      this.customize_randomizer = $(this.status_container.find('div.button-container a.randomize-options'));
      this.misc_settings = $(this.status_container.find('div.button-container a.misc-settings'));
      this.backend_status = $(this.status_container.find('.backend-status'));
      this.backend_status.hide();
      this.collection_button = $(this.status_container.find('div.button-container a.collection'));
      this.collection_button.click((e) => {
        e.preventDefault();
        if (!this.collection_button.prop('disabled')) {
          return this.collection.modal.modal('show');
        }
      });
      this.squad_name_input.keypress((e) => {
        if (e.which === 13) {
          this.squad_name_save_button.click();
          return false;
        }
      });
      this.squad_name_input.change((e) => {
        return this.backend_status.fadeOut('slow');
      });
      this.squad_name_input.blur((e) => {
        this.squad_name_input.change();
        return this.squad_name_save_button.click();
      });
      this.squad_name_display.click((e) => {
        e.preventDefault();
        this.squad_name_display.hide();
        this.squad_name_input.val($.trim(this.current_squad.name));
        // Because Firefox handles this badly
        window.setTimeout(() => {
          this.squad_name_input.focus();
          return this.squad_name_input.select();
        }, 100);
        return this.squad_name_input.closest('div').show();
      });
      this.squad_name_save_button.click((e) => {
        var name;
        e.preventDefault();
        this.current_squad.dirty = true;
        this.container.trigger('xwing-backend:squadDirtinessChanged');
        name = this.current_squad.name = $.trim(this.squad_name_input.val());
        if (name.length > 0) {
          this.squad_name_display.show();
          this.container.trigger('xwing-backend:squadNameChanged');
          return this.squad_name_input.closest('div').hide();
        }
      });
      this.randomizer_options_modal = $(document.createElement('DIV'));
      this.randomizer_options_modal.addClass('modal fade randomizer-modal');
      this.randomizer_options_modal.tabindex = "-1";
      this.randomizer_options_modal.role = "dialog";
      $('body').append(this.randomizer_options_modal);
      this.randomizer_options_modal.append($.trim(`<div class="modal-dialog modal-dialog-scrollable modal-dialog-centered" role="document">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="translated" defaultText="Random Squad Builder Options"></h3>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        </div>
        <div class="modal-body">
            <form>
                <label>
                    <span class="translated" defaultText="Maximum Ship Count"></span>
                    <input type="number" class="randomizer-ship-limit" value="${DEFAULT_RANDOMIZER_SHIP_LIMIT}" placeholder="${DEFAULT_RANDOMIZER_SHIP_LIMIT}" />
                </label><br />
                <label>
                    <input type="checkbox" class="randomizer-collection-only" checked="checked"/> 
                    <span class="translated" defaultText="Limit to collection"></span>
                </label><br />
                <label>
                    <span class="translated" defaultText="Sets and Expansions"></span>
                    <select class="randomizer-sources" multiple="1" data-placeholder='` + this.uitranslation('All sets and expansions') + `'>
                    </select>
                </label><br />
                <label>
                    <input type="checkbox" class="randomizer-fill-zero-pts" /> 
                    <span class="translated" defaultText="Always fill 0-point slots"></span>
                </label><br />
                <label>
                    <span class="translated" defaultText="Maximum Seconds to Spend Randomizing"></span>
                    <input type="number" class="randomizer-timeout" value="${DEFAULT_RANDOMIZER_TIMEOUT_SEC}" placeholder="${DEFAULT_RANDOMIZER_TIMEOUT_SEC}" />
                </label>
            </form>
        </div>
        <div class="modal-footer">
            <button class="btn btn-primary do-randomize translated" aria-hidden="true" defaultText="Roll!"></button>
            <button class="btn translated" data-dismiss="modal" aria-hidden="true" defaultText="Close"></button>
        </div>
    </div>
</div>`));
      // translate the UI we just created. 
      exportObj.translateUIElements(this.randomizer_options_modal);
      this.randomizer_source_selector = $(this.randomizer_options_modal.find('select.randomizer-sources'));
      ref = exportObj.expansions;
      for (j = 0, len = ref.length; j < len; j++) {
        expansion = ref[j];
        opt = $(document.createElement('OPTION'));
        opt.text(expansion);
        this.randomizer_source_selector.append(opt);
      }
      this.randomizer_source_selector.select2({
        width: "100%",
        minimumResultsForSearch: $.isMobile() ? -1 : 0
      });
      this.randomizer_collection_selector = ($(this.randomizer_options_modal.find('.randomizer-collection-only')))[0];
      this.randomizer_fill_zero_pts = ($(this.randomizer_options_modal.find('.randomizer-fill-zero-pts')))[0];
      this.randomize_button.click((e) => {
        var points, ship_limit, timeout_sec;
        e.preventDefault();
        if (this.current_squad.dirty && (this.backend != null)) {
          return this.backend.warnUnsaved(this, () => {
            return this.randomize_button.click();
          });
        } else {
          points = parseInt(this.desired_points_input.val());
          if (isNaN(points) || points <= 0) {
            points = DEFAULT_RANDOMIZER_POINTS;
          }
          ship_limit = parseInt($(this.randomizer_options_modal.find('.randomizer-ship-limit')).val());
          if (isNaN(ship_limit) || ship_limit < 0) {
            ship_limit = DEFAULT_RANDOMIZER_SHIP_LIMIT;
          }
          timeout_sec = parseInt($(this.randomizer_options_modal.find('.randomizer-timeout')).val());
          if (isNaN(timeout_sec) || timeout_sec <= 0) {
            timeout_sec = DEFAULT_RANDOMIZER_TIMEOUT_SEC;
          }
          // console.log "points=#{points}, sources=#{@randomizer_source_selector.val()}, timeout=#{timeout_sec}"
          return this.randomSquad(points, this.randomizer_source_selector.val(), timeout_sec * 1000, ship_limit, this.randomizer_collection_selector.checked, this.randomizer_fill_zero_pts.checked);
        }
      });
      this.randomizer_options_modal.find('button.do-randomize').click((e) => {
        e.preventDefault();
        this.randomizer_options_modal.modal('hide');
        return this.randomize_button.click();
      });
      this.customize_randomizer.click((e) => {
        e.preventDefault();
        return this.randomizer_options_modal.modal();
      });
      this.misc_settings_modal = $(document.createElement('DIV'));
      this.misc_settings_modal.addClass('modal fade');
      this.misc_settings_modal.tabindex = "-1";
      this.misc_settings_modal.role = "dialog";
      $('body').append(this.misc_settings_modal);
      this.misc_settings_modal.append($.trim(`<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="translated" defaultText="Miscellaneous Settings"></h3>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        </div>
        <div class="modal-body">
            <label class = "toggle-initiative-prefix-names misc-settings-label">
                <input type="checkbox" class="initiative-prefix-names-checkbox misc-settings-checkbox" /> <span class="translated" defaultText="Use INI prefix"></span> 
            </label><br />
            <label class = "enable-ban-list misc-settings-label">
                <input type="checkbox" class="enable-ban-list-checkbox misc-settings-checkbox" /> <span class="translated" defaultText="Enable Ban List (Not Standard)"></span> 
            </label><br />
        </div>
        <div class="modal-footer">
            <span class="misc-settings-infoline"></span>
            &nbsp;
            <button class="btn translated" data-dismiss="modal" aria-hidden="true" defaultText="Close"></button>
        </div>
    </div>
</div>`));
      this.misc_settings_infoline = $(this.misc_settings_modal.find('.misc-settings-infoline'));
      this.misc_settings_initiative_prefix = $(this.misc_settings_modal.find('.initiative-prefix-names-checkbox'));
      this.misc_settings_ban_list = $(this.misc_settings_modal.find('.enable-ban-list-checkbox'));
      if (this.backend != null) {
        this.backend.getSettings((st) => {
          if (exportObj.settings == null) {
            exportObj.settings = [];
          }
          exportObj.settings.initiative_prefix = st.showInitiativeInFrontOfPilotName != null;
          if (st.showInitiativeInFrontOfPilotName != null) {
            this.misc_settings_initiative_prefix.prop('checked', true);
          }
          exportObj.settings.ban_list = st.enableBanList != null;
          if (st.enableBanList != null) {
            return this.misc_settings_ban_list.prop('checked', true);
          }
        });
      } else {
        if (this.waiting_for_backend == null) {
          this.waiting_for_backend = [];
        }
        this.waiting_for_backend.push(() => {
          return this.backend.getSettings((st) => {
            if (exportObj.settings == null) {
              exportObj.settings = [];
            }
            exportObj.settings.initiative_prefix = st.showInitiativeInFrontOfPilotName != null;
            if (st.showInitiativeInFrontOfPilotName != null) {
              this.misc_settings_initiative_prefix.prop('checked', true);
            }
            exportObj.settings.ban_list = st.enableBanList != null;
            if (st.enableBanList != null) {
              return this.misc_settings_ban_list.prop('checked', true);
            }
          });
        });
      }
      this.misc_settings_initiative_prefix.click((e) => {
        if (exportObj.settings == null) {
          exportObj.settings = [];
        }
        exportObj.settings.initiative_prefix = this.misc_settings_initiative_prefix.prop('checked');
        if (this.backend != null) {
          if (this.misc_settings_initiative_prefix.prop('checked')) {
            return this.backend.set('showInitiativeInFrontOfPilotName', '1', (ds) => {
              this.misc_settings_infoline.text(this.uitranslation("Changes Saved"));
              return this.misc_settings_infoline.fadeIn(100, () => {
                return this.misc_settings_infoline.fadeOut(3000);
              });
            });
          } else {
            return this.backend.deleteSetting('showInitiativeInFrontOfPilotName', (dd) => {
              this.misc_settings_infoline.text(this.uitranslation("Changes Saved"));
              return this.misc_settings_infoline.fadeIn(100, () => {
                return this.misc_settings_infoline.fadeOut(3000);
              });
            });
          }
        }
      });
      this.misc_settings_ban_list.click((e) => {
        if (exportObj.settings == null) {
          exportObj.settings = [];
        }
        exportObj.settings.ban_list = this.misc_settings_ban_list.prop('checked');
        if (this.backend != null) {
          if (this.misc_settings_ban_list.prop('checked')) {
            return this.backend.set('enableBanList', '1', (ds) => {
              this.misc_settings_infoline.text(this.uitranslation("Changes Saved"));
              return this.misc_settings_infoline.fadeIn(100, () => {
                return this.misc_settings_infoline.fadeOut(3000);
              });
            });
          } else {
            return this.backend.deleteSetting('enableBanList', (dd) => {
              this.misc_settings_infoline.text(this.uitranslation("Changes Saved"));
              return this.misc_settings_infoline.fadeIn(100, () => {
                return this.misc_settings_infoline.fadeOut(3000);
              });
            });
          }
        }
      });
      this.misc_settings.click((e) => {
        var ref1;
        e.preventDefault();
        this.misc_settings_modal.modal();
        return this.misc_settings_initiative_prefix.prop('checked', (((ref1 = exportObj.settings) != null ? ref1.initiative_prefix : void 0) != null) && exportObj.settings.initiative_prefix);
      });
      exportObj.translateUIElements(this.misc_settings_modal);
      this.choose_obstacles_modal = $(document.createElement('DIV'));
      this.choose_obstacles_modal.addClass('modal fade choose-obstacles-modal');
      this.choose_obstacles_modal.tabindex = "-1";
      this.choose_obstacles_modal.role = "dialog";
      this.container.append(this.choose_obstacles_modal);
      this.choose_obstacles_modal.append($.trim(`<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
    <div class="modal-content">
        <div class="modal-header">
            <label class='choose-obstacles-description translated' defaultText="Choose obstacles dialog"></label>
        </div>
        <div class="modal-body row">
            <div class="obstacle-select-container col-md-12">
            </div>
            <div>
                <div class="obstacle-sources-container">
                    <span class="info-header obstacle-sources translated" defaultText="Sources:" style="padding-left: 8px;"></span> <br>
                    <div class="info-data obstacle-sources" style="padding-left: 8px;padding-right:10px;"></div>
                </div>
            </div>
        </div>
        <div class="modal-footer d-print-none">
            <button class="btn btn-danger reset-obstacles translated" defaultText="Reset Obstacles"></button>
            <button class="btn btn-danger close-print-dialog translated" data-dismiss="modal" aria-hidden="true" defaultText="Close"></button>
        </div>
    </div>
</div>`));
      this.obstacles_reset = this.choose_obstacles_modal.find('.reset-obstacles');
      this.obstacles_select = this.choose_obstacles_modal.find('.obstacle-select-container');
      this.obstacles_select_sources = this.choose_obstacles_modal.find('.info-data.obstacle-sources');
      obstacleFormat = function(state) {
        var image_name;
        image_name = 'images/' + state.id + '.png';
        return `<img class='obstacle' src='${image_name}' style='height: 100px;' /></br>` + state.text;
      };
      this.obstacle_data = [
        {
          id: "coreasteroid0",
          text: "Core Asteroid 1"
        },
        {
          id: "coreasteroid1",
          text: "Core Asteroid 2"
        },
        {
          id: "coreasteroid2",
          text: "Core Asteroid 3"
        },
        {
          id: "coreasteroid3",
          text: "Core Asteroid 4"
        },
        {
          id: "coreasteroid4",
          text: "Core Asteroid 5"
        },
        {
          id: "coreasteroid5",
          text: "Core Asteroid 6"
        },
        {
          id: "yt2400debris0",
          text: "YT2400 Debris 1"
        },
        {
          id: "yt2400debris1",
          text: "YT2400 Debris 2"
        },
        {
          id: "yt2400debris2",
          text: "YT2400 Debris 3"
        },
        {
          id: "vt49decimatordebris0",
          text: "VT49 Debris 1"
        },
        {
          id: "vt49decimatordebris1",
          text: "VT49 Debris 2"
        },
        {
          id: "vt49decimatordebris2",
          text: "VT49 Debris 3"
        },
        {
          id: "core2asteroid0",
          text: "FA Asteroid 1"
        },
        {
          id: "core2asteroid1",
          text: "FA Asteroid 2"
        },
        {
          id: "core2asteroid2",
          text: "FA Asteroid 3"
        },
        {
          id: "core2asteroid3",
          text: "FA Asteroid 4"
        },
        {
          id: "core2asteroid4",
          text: "FA Asteroid 5"
        },
        {
          id: "core2asteroid5",
          text: "FA Asteroid 6"
        },
        {
          id: "gascloud1",
          text: "Gas Cloud 1"
        },
        {
          id: "gascloud2",
          text: "Gas Cloud 2"
        },
        {
          id: "gascloud3",
          text: "Gas Cloud 3"
        },
        {
          id: "gascloud4",
          text: "Gas Cloud 4"
        },
        {
          id: "gascloud5",
          text: "Gas Cloud 5"
        },
        {
          id: "gascloud6",
          text: "Gas Cloud 6"
        },
        {
          id: "pomasteroid1",
          text: "PoM Rock 1"
        },
        {
          id: "pomasteroid2",
          text: "PoM Rock 2"
        },
        {
          id: "pomasteroid3",
          text: "PoM Rock 3"
        },
        {
          id: "pomdebris1",
          text: "PoM Debris 1"
        },
        {
          id: "pomdebris2",
          text: "PoM Debris 2"
        },
        {
          id: "pomdebris3",
          text: "PoM Debris 3"
        }
      ];
      this.obstacles_select.select2({
        data: this.obstacle_data,
        width: '90%',
        multiple: true,
        maximumSelectionSize: 3,
        placeholder: "Select an Obstacle",
        minimumResultsForSearch: $.isMobile() ? -1 : 0,
        formatResult: obstacleFormat,
        formatSelection: obstacleFormat
      });
      if ($.isMobile()) {
        // Backend
        this.obstacles_select.select2.minimumResultsForSearch = -1;
      }
      this.backend_list_squads_button = $(this.container.find('button.backend-list-my-squads'));
      this.backend_list_squads_button.click((e) => {
        e.preventDefault();
        if (this.backend != null) {
          return this.backend.list(this);
        }
      });
      this.backend_save_list_button = $(this.container.find('button.save-list'));
      this.backend_save_list_button.click(async(e) => {
        var additional_data;
        e.preventDefault();
        if ((this.backend != null) && !this.backend_save_list_button.hasClass('disabled')) {
          additional_data = {
            points: this.total_points,
            description: this.describeSquad(),
            cards: this.listCards(),
            notes: this.notes.val().substr(0, 1024),
            obstacles: this.getObstacles(),
            tag: this.tag.val().substr(0, 1024)
          };
          this.backend_status.html($.trim(`<i class="fa fa-sync fa-spin"></i>&nbsp;<span class="translated" defaultText="Saving squad..."></span>`));
          this.backend_status.show();
          this.backend_save_list_button.addClass('disabled');
          return (await this.backend.save(this.serialize(), this.current_squad.id, this.current_squad.name, this.faction, additional_data, (results) => {
            if (results.success) {
              this.current_squad.dirty = false;
              if (this.current_squad.id != null) {
                this.backend_status.html($.trim(`<i class="fa fa-check"></i>&nbsp;<span class="translated" defaultText="Squad updated successfully."></span>`));
              } else {
                this.backend_status.html($.trim(`<i class="fa fa-check"></i>&nbsp;<span class="translated" defaultText="New squad saved successfully."></span>`));
                this.current_squad.id = results.id;
              }
              return this.container.trigger('xwing-backend:squadDirtinessChanged');
            } else {
              this.backend_status.html($.trim(`<i class="fa fa-exclamation-circle"></i>&nbsp;${results.error}`));
              return this.backend_save_list_button.removeClass('disabled');
            }
          }));
        }
      });
      this.backend_save_list_as_button = $(this.container.find('button.save-list-as'));
      this.backend_save_list_as_button.addClass('disabled');
      this.backend_save_list_as_button.click((e) => {
        e.preventDefault();
        if ((this.backend != null) && !this.backend_save_list_as_button.hasClass('disabled')) {
          return this.backend.showSaveAsModal(this);
        }
      });
      this.backend_delete_list_button = $(this.container.find('button.delete-list'));
      this.backend_delete_list_button.click((e) => {
        e.preventDefault();
        if ((this.backend != null) && !this.backend_delete_list_button.hasClass('disabled')) {
          return this.backend.showDeleteModal(this);
        }
      });
      content_container = $(document.createElement('DIV'));
      content_container.addClass('container-fluid');
      this.container.append(content_container);
      content_container.append($.trim(`<div class="row">
    <div class="col-md-9 ship-container">
        <label class="unsortable notes-container show-authenticated col-md-10">
            <span class="notes-name translated" defaultText="Squad Notes:"></span>
            <br />
            <textarea class="squad-notes"></textarea>
            <br />
            <span class="tag-name translated" defaultText="Tag:"></span>
            <input type="search" class="squad-tag"></input>
        </label>
        <div class="unsortable obstacles-container">
                <button class="btn btn-info choose-obstacles"><i class="fa fa-cloud"></i>&nbsp;<span class="translated" defaultText="Choose Obstacles"</span></button>
        </div>
    </div>
    <div class="col-md-3 info-container" id="info-container">
    </div>
</div>`));
      this.ship_container = $(content_container.find('div.ship-container'));
      this.info_container = $(content_container.find('div.info-container'));
      this.obstacles_container = content_container.find('.obstacles-container');
      this.notes_container = $(content_container.find('.notes-container'));
      this.notes = $(this.notes_container.find('textarea.squad-notes'));
      this.tag = $(this.notes_container.find('input.squad-tag'));
      this.ship_container.sortable({
        cancel: '.unsortable'
      });
      this.info_container.append($.trim(this.createInfoContainerUI()));
      this.info_container.find('.info-well').hide();
      this.info_intro = this.info_container.find('.intro');
      this.print_list_button = $(this.container.find('button.print-list'));
      this.container.find('[rel=tooltip]').tooltip();
      // obstacles
      this.obstacles_button = $(this.container.find('button.choose-obstacles'));
      this.obstacles_button.click((e) => {
        e.preventDefault();
        return this.showChooseObstaclesModal();
      });
      // conditions
      this.condition_container = $(document.createElement('div'));
      this.condition_container.addClass('conditions-container d-flex flex-wrap');
      this.container.append(this.condition_container);
      this.mobile_tooltip_modal = $(document.createElement('DIV'));
      this.mobile_tooltip_modal.addClass('modal fade choose-obstacles-modal d-print-none');
      this.mobile_tooltip_modal.tabindex = "-1";
      this.mobile_tooltip_modal.role = "dialog";
      this.container.append(this.mobile_tooltip_modal);
      this.mobile_tooltip_modal.append($.trim(`<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
    <div class="modal-content">
        <div class="modal-header">
        </div>
        <div class="modal-body">` + this.createInfoContainerUI(false) + `        </div>
        <div class="modal-footer">
            <button class="btn btn-danger close-print-dialog translated" data-dismiss="modal" aria-hidden="true" defaultText="Close"></button>
        </div>
    </div>
</div>`));
      this.mobile_tooltip_modal.find('intro').hide();
      // translate all the UI we just created to current language
      return exportObj.translateUIElements(this.container);
    }

    createInfoContainerUI(include_intro = true) {
      var intro;
      if (include_intro === true) {
        intro = `<div class="card intro translated" defaultText="Intro Card YASB">
</div>`;
      } else {
        intro = "";
      }
      return `${intro}
<div class="card info-well">
    <div class="info-name"></div>
    <div class="info-type"></div>
    <span class="info-collection"></span>
    <div class="row">
        <div class="col-sm-5">
            <table class="table-sm">
                <tbody>
                    <tr class="info-attack-bullseye">
                        <td class="info-header"><i class="xwing-miniatures-font header-attack xwing-miniatures-font-bullseyearc"></i></td>
                        <td class="info-data info-attack"></td>
                    </tr>
                    <tr class="info-attack">
                        <td class="info-header"><i class="xwing-miniatures-font header-attack xwing-miniatures-font-frontarc"></i></td>
                        <td class="info-data info-attack"></td>
                    </tr>
                    <tr class="info-attack-fullfront">
                        <td class="info-header"><i class="xwing-miniatures-font header-attack xwing-miniatures-font-fullfrontarc"></i></td>
                        <td class="info-data info-attack"></td>
                    </tr>
                    <tr class="info-attack-left">
                        <td class="info-header"><i class="xwing-miniatures-font header-attack xwing-miniatures-font-leftarc"></i></td>
                        <td class="info-data info-attack"></td>
                    </tr>
                    <tr class="info-attack-right">
                        <td class="info-header"><i class="xwing-miniatures-font header-attack xwing-miniatures-font-rightarc"></i></td>
                        <td class="info-data info-attack"></td>
                    </tr>
                    <tr class="info-attack-back">
                        <td class="info-header"><i class="xwing-miniatures-font header-attack xwing-miniatures-font-reararc"></i></td>
                        <td class="info-data info-attack"></td>
                    </tr>
                    <tr class="info-attack-turret">
                        <td class="info-header"><i class="xwing-miniatures-font header-attack xwing-miniatures-font-singleturretarc"></i></td>
                        <td class="info-data info-attack"></td>
                    </tr>
                    <tr class="info-attack-doubleturret">
                        <td class="info-header"><i class="xwing-miniatures-font header-attack xwing-miniatures-font-doubleturretarc"></i></td>
                        <td class="info-data info-attack"></td>
                    </tr>
                    <tr class="info-agility">
                        <td class="info-header"><i class="xwing-miniatures-font header-agility xwing-miniatures-font-agility"></i></td>
                        <td class="info-data info-agility"></td>
                    </tr>
                    <tr class="info-hull">
                        <td class="info-header"><i class="xwing-miniatures-font header-hull xwing-miniatures-font-hull"></i></td>
                        <td class="info-data info-hull"></td>
                    </tr>
                    <tr class="info-shields">
                        <td class="info-header"><i class="xwing-miniatures-font header-shield xwing-miniatures-font-shield"></i></td>
                        <td class="info-data info-shields"></td>
                    </tr>
                    <tr class="info-force">
                        <td class="info-header"><i class="xwing-miniatures-font header-force xwing-miniatures-font-forcecharge"></i></td>
                        <td class="info-data info-force"></td>
                    </tr>
                    <tr class="info-charge">
                        <td class="info-header"><i class="xwing-miniatures-font header-charge xwing-miniatures-font-charge"></i></td>
                        <td class="info-data info-charge"></td>
                    </tr>
                    <tr class="info-energy">
                        <td class="info-header"><i class="xwing-miniatures-font header-energy xwing-miniatures-font-energy"></i></td>
                        <td class="info-data info-energy"></td>
                    </tr>
                    <tr class="info-range">
                        <td class="info-header translated" defaultText="Range"></td>
                        <td class="info-data info-range"></td><td class="info-rangebonus"><i class="xwing-miniatures-font red header-range xwing-miniatures-font-rangebonusindicator"></i></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="col-sm-7">
            <table class="table-sm">
                <tbody>
                    <tr class="info-skill">
                        <td class="info-header translated" defaultText="Initiative"></td>
                        <td class="info-data info-skill"></td>
                    </tr>
                    <tr class="info-engagement">
                        <td class="info-header translated" defaultText="Engagement"></td>
                        <td class="info-data info-engagement"></td>
                    </tr>
                    <tr class="info-faction">
                        <td class="info-header translated" defaultText="Faction"></td>
                        <td class="info-data"></td>
                    </tr>
                    <tr class="info-base">
                        <td class="info-header translated" defaultText="Base"></td>
                        <td class="info-data"></td> 
                    </tr>
                    <tr class="info-points">
                        <td class="info-header translated" defaultText="Points"></td>
                        <td class="info-data info-points"></td>
                    </tr>
                    <tr class="info-loadout">
                        <td class="info-header translated" defaultText="Loadout"></td>
                        <td class="info-data info-loadout"></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <table class="table-sm">
        <tbody>
            <tr class="info-ship">
                <td class="info-header translated" defaultText="Ship"></td>
                <td class="info-data"></td>
            </tr>
            <tr class="info-actions">
                <td class="info-header translated" defaultText="Actions"></td>
                <td class="info-data"></td>
            </tr>
            <tr class="info-upgrades">
                <td class="info-header translated" defaultText="Upgrades"></td>
                <td class="info-data"></td>
            </tr>
        </tbody>
    </table>
    <p class="info-restrictions"></p>
    <p class="info-text"></p>
    <p class="info-chassis"></p>
    <p class="info-maneuvers"></p>
    <br />
    <span class="info-header info-sources translated" defaultText="Sources:"></span> 
    <span class="info-data info-sources"></span>
</div>`;
    }

    setupEventHandlers() {
      this.container.on('xwing:claimUnique', (e, unique, type, cb) => {
        return this.claimUnique(unique, type, cb);
      }).on('xwing:releaseUnique', (e, unique, type, cb) => {
        return this.releaseUnique(unique, type, cb);
      }).on('xwing:pointsUpdated', (e, cb = $.noop) => {
        if (this.isUpdatingPoints) {
          return cb();
        } else {
          this.isUpdatingPoints = true;
          return this.onPointsUpdated(() => {
            this.isUpdatingPoints = false;
            return cb();
          });
        }
      }).on('xwing-backend:squadLoadRequested', (e, squad, cb = $.noop) => {
        return this.onSquadLoadRequested(squad, cb);
      }).on('xwing-backend:squadDirtinessChanged', (e) => {
        return this.onSquadDirtinessChanged();
      }).on('xwing-backend:squadNameChanged', (e) => {
        return this.onSquadNameChanged();
      }).on('xwing:beforeLanguageLoad', (e, cb = $.noop) => {
        this.pretranslation_serialized = this.serialize();
        return cb();
      }).on('xwing:afterLanguageLoad', (e, language, cb = $.noop) => {
        var j, len, old_dirty, ref, ship;
        if (this.language !== language) {
          this.language = language;
          old_dirty = this.current_squad.dirty;
          if (this.pretranslation_serialized.length != null) {
            this.loadFromSerialized(this.pretranslation_serialized);
          }
          ref = this.ships;
          for (j = 0, len = ref.length; j < len; j++) {
            ship = ref[j];
            ship.updateSelections();
          }
          this.current_squad.dirty = old_dirty;
          this.pretranslation_serialized = void 0;
        }
        return cb();
      // Recently moved this here.  Did this ever work?
      }).on('xwing:shipUpdated', (e, cb = $.noop) => {
        var all_allocated, j, len, ref, ship;
        all_allocated = true;
        ref = this.ships;
        for (j = 0, len = ref.length; j < len; j++) {
          ship = ref[j];
          ship.updateSelections();
          if (ship.ship_selector.val() === '') {
            all_allocated = false;
          }
        }
        if (all_allocated && !this.suppress_automatic_new_ship) {
          //console.log "all_allocated is #{all_allocated}, suppress_automatic_new_ship is #{@suppress_automatic_new_ship}"
          //console.log "should we add ship: #{all_allocated and not @suppress_automatic_new_ship}"
          return this.addShip();
        }
      });
      $(window).on('xwing-backend:authenticationChanged', (e) => {
        return this.resetCurrentSquad();
      }).on('xwing-collection:created', (e, collection) => {
        // console.log "#{@faction}: collection was created"
        this.collection = collection;
        // console.log "#{@faction}: Collection created, checking squad"
        // @collection.onLanguageChange null, @language
        this.checkCollection();
        return this.collection_button.removeClass('d-none');
      }).on('xwing-collection:changed', (e, collection) => {
        // console.log "#{@faction}: Collection changed, checking squad"
        return this.checkCollection();
      }).on('xwing-collection:destroyed', (e, collection) => {
        this.collection = null;
        return this.collection_button.addClass('d-none');
      }).on('xwing:pingActiveBuilder', (e, cb) => {
        if (this.container.is(':visible')) {
          return cb(this);
        }
      }).on('xwing:activateBuilder', (e, faction, cb) => {
        if (faction === this.faction) {
          this.tab.tab('show');
          return cb(this);
        }
      }).on('xwing:gameTypeChanged', (e, gameType, cb = $.noop) => {
        this.onGameTypeChanged(gameType, cb);
        if (this.game_type_selector.val() !== gameType) {
          return this.game_type_selector.val(gameType).trigger('change');
        }
      });
      this.ship_container.on('sortstart', (e, ui) => {
        return this.oldIndex = ui.item.index();
      }).on('sortstop', (e, ui) => {
        return this.updateShipOrder(this.oldIndex, ui.item.index());
      });
      this.obstacles_reset.click((e) => {
        if (this.current_obstacles !== []) {
          this.current_obstacles = [];
          this.obstacles_select.select2('data', null);
          this.current_squad.additional_data.obstacles = this.current_obstacles;
          this.current_squad.dirty = true;
          this.container.trigger('xwing-backend:squadDirtinessChanged');
          return this.container.trigger('xwing:pointsUpdated');
        }
      });
      this.obstacles_select.change((e) => {
        this.current_obstacles = this.obstacles_select.val().split(',');
        this.current_squad.additional_data.obstacles = this.current_obstacles;
        this.current_squad.dirty = true;
        this.showObstaclesSelectInfo();
        this.container.trigger('xwing-backend:squadDirtinessChanged');
        return this.container.trigger('xwing:pointsUpdated');
      });
      this.view_list_button.click((e) => {
        e.preventDefault();
        return this.showTextListModal();
      });
      //Print Button
      this.print_list_button.click((e) => {
        var container, expanded_hull_and_shield, faction, j, l, len, len1, len2, len3, len4, len5, len6, m, o, obstaclelist, obstaclename, obstacles, q, query, ref, ref1, ref2, ref3, ref4, ref5, ref6, rules, sectiontext, ship, text, triggertext, upgrade, versioninfo, y, z;
        e.preventDefault();
        // Copy text list to printable
        this.printable_container.find('.printable-header').html(this.list_modal.find('.modal-header').html());
        this.printable_container.find('.printable-body').text('');
        switch (this.list_display_mode) {
          case 'simple':
            this.printable_container.find('.printable-body').html(this.simple_container.html());
            break;
          default:
            ref = this.ships;
            for (j = 0, len = ref.length; j < len; j++) {
              ship = ref[j];
              if (ship.pilot != null) {
                this.printable_container.find('.printable-body').append(ship.toHTML());
              }
            }
            if (this.list_modal.find('.toggle-horizontal-space').prop('checked')) {
              this.printable_container.find('.upgrade-container').addClass('wide');
            }
            this.printable_container.find('.printable-body').toggleClass('bw', !this.list_modal.find('.toggle-color-print').prop('checked'));
            if (this.list_modal.find('.toggle-skip-text-print').prop('checked')) {
              ref1 = this.printable_container.find('.upgrade-text, .fancy-pilot-text');
              for (l = 0, len1 = ref1.length; l < len1; l++) {
                text = ref1[l];
                text.hidden = true;
              }
            }
            if (this.list_modal.find('.toggle-maneuver-print').prop('checked')) {
              this.printable_container.find('.printable-body').append(this.getSquadDialsAsHTML());
            }
            expanded_hull_and_shield = this.list_modal.find('.toggle-expanded-shield-hull-print').prop('checked');
            ref2 = this.printable_container.find('.expanded-hull-or-shield');
            for (m = 0, len2 = ref2.length; m < len2; m++) {
              container = ref2[m];
              container.hidden = !expanded_hull_and_shield;
            }
            ref3 = this.printable_container.find('.simple-hull-or-shield');
            for (o = 0, len3 = ref3.length; o < len3; o++) {
              container = ref3[o];
              container.hidden = expanded_hull_and_shield;
            }
            faction = (function() {
              switch (this.faction) {
                case 'Rebel Alliance':
                  return 'rebel';
                case 'Galactic Empire':
                  return 'empire';
                case 'Scum and Villainy':
                  return 'scum';
                case 'Resistance':
                  return 'rebel-outline';
                case 'First Order':
                  return 'firstorder';
                case 'Galactic Republic':
                  return 'republic';
                case 'Separatist Alliance':
                  return 'separatists';
                case 'All':
                  return 'first-player-4';
              }
            }).call(this);
            if (this.list_modal.find('.toggle-color-print').prop('checked')) {
              this.printable_container.find('.fancy-header').addClass(faction);
            }
            if (this.list_modal.find('.toggle-color-print').prop('checked')) {
              this.printable_container.find('.fancy-pilot-header').addClass(`${faction}-pilot`);
            }
            this.printable_container.find('.squad-faction').html(`<i class="xwing-miniatures-font xwing-miniatures-font-${faction}"></i>`);
        }
        // List type
        if (this.isStandard) {
          this.printable_container.find('.squad-name').append(` <i class="xwing-miniatures-font xwing-miniatures-font-first-player-1"></i>`);
        }
        if (this.isEpic) {
          this.printable_container.find('.squad-name').append(` <i class="xwing-miniatures-font xwing-miniatures-font-energy"></i>`);
        }
        if (this.isXwa) {
          this.printable_container.find('.squad-name').append(` <i class="xwing-miniatures-font xwing-miniatures-font-point"></i>`);
        }
        versioninfo = "09/06/2024";
        rules = "AMG";
        if (this.isXwa) {
          versioninfo = "R1";
          rules = "XWA";
        }
        // Version number
        this.printable_container.find('.fancy-under-header').append($.trim(`<div class="version">Points Version: ${rules} - ${versioninfo}</div>`));
        
        // Notes, if present
        if ($.trim(this.notes.val()) !== '') {
          this.printable_container.find('.printable-body').append($.trim(`<h5 class="print-notes translated" defaultText="Notes:"></h5>
<pre class="print-notes"></pre>`));
          this.printable_container.find('.printable-body pre.print-notes').text(this.notes.val());
        } else {

        }
        // Conditions
        this.printable_container.find('.printable-body').append($.trim(`<div class="print-conditions"></div>`));
        this.printable_container.find('.printable-body .print-conditions').html(this.condition_container.html());
        // Obstacles
        if (this.list_modal.find('.toggle-obstacles').prop('checked')) {
          obstacles = this.getObstacles();
          obstaclelist = "";
          for (q = 0, len4 = obstacles.length; q < len4; q++) {
            obstaclename = obstacles[q];
            obstaclelist += `<img class="obstacle-silhouettes" src="images/${obstaclename}.png" />`;
          }
          this.printable_container.find('.printable-body').append($.trim(`<div class="obstacles">
    <div>Chosen Obstacles:<br>${obstaclelist}</div>
</div>`));
        }
        // Add QR code
        query = this.getPermaLinkParams(['sn', 'obs']);
        if ((query != null) && this.list_modal.find('.toggle-juggler-qrcode').prop('checked')) {
          this.printable_container.find('.printable-body').append($.trim(`<div class="qrcode-container">
    <div class="permalink-container">
        <div class="qrcode">YASB Link</div>
        <div class="qrcode-text translated" defaultText="Scan QR-Code"></div>
    </div>
    <div class="xws-container">
        <div class="qrcode">XWS Data</div>
        <div class="qrcode-text translated" defaultText="XWS QR-Code"></div>
    </div>
</div>`));
          text = JSON.stringify(this.toXWS());
          console.log(`${text}`);
          this.printable_container.find('.xws-container .qrcode').qrcode({
            render: 'div',
            ec: 'M',
            size: text.length < 144 ? 144 : 256,
            text: text
          });
          text = `https://yasb.app/${query}`;
          this.printable_container.find('.permalink-container .qrcode').qrcode({
            render: 'div',
            ec: 'M',
            size: text.length < 144 ? 144 : 256,
            text: text
          });
        }
        //Trigger List
        triggertext = "while you perform";
        sectiontext = "";
        ref4 = this.ships;
        for (y = 0, len5 = ref4.length; y < len5; y++) {
          ship = ref4[y];
          if ((((ref5 = ship.pilot) != null ? ref5.text : void 0) != null) && (ship.pilot.text.match(triggertext) > -1)) {
            sectiontext = sectiontext + `${ship.pilot.name} <br><br>`;
          }
          ref6 = ship.upgrades;
          for (z = 0, len6 = ref6.length; z < len6; z++) {
            upgrade = ref6[z];
            if ((upgrade.text != null) && (upgrade.text.match(triggertext) > -1)) {
              sectiontext = sectiontext + `${upgrade.name} <br><br>`;
            }
          }
        }
        return window.print();
      });
      $(window).resize(() => {
        var j, len, ref, results1, ship;
        if ($(window).width() < 768 && this.list_display_mode !== 'simple') {
          this.select_simple_view_button.click();
        }
        ref = this.ships;
        results1 = [];
        for (j = 0, len = ref.length; j < len; j++) {
          ship = ref[j];
          results1.push(ship.checkPilotSelectorQueryModal());
        }
        return results1;
      });
      this.notes.change(this.onNotesUpdated);
      this.tag.change(this.onNotesUpdated);
      this.notes.on('keyup', this.onNotesUpdated);
      return this.tag.on('keyup', this.onNotesUpdated);
    }

    getPermaLinkParams(ignored_params = []) {
      var k, params, v;
      params = {};
      if (indexOf.call(ignored_params, 'f') < 0) {
        params.f = encodeURI(this.faction);
      }
      if (indexOf.call(ignored_params, 'd') < 0) {
        params.d = encodeURI(this.serialize());
      }
      if (indexOf.call(ignored_params, 'sn') < 0) {
        params.sn = encodeURIComponent(this.current_squad.name);
      }
      if (indexOf.call(ignored_params, 'obs') < 0) {
        params.obs = encodeURI(this.current_squad.additional_data.obstacles || '');
      }
      return "?" + ((function() {
        var results1;
        results1 = [];
        for (k in params) {
          v = params[k];
          results1.push(`${k}=${v}`);
        }
        return results1;
      })()).join("&");
    }

    getPermaLink(params = this.getPermaLinkParams()) {
      return `${URL_BASE}${params}`;
    }

    updateShipOrder(oldpos, newpos) {
      var selectedShip;
      selectedShip = this.ships[oldpos];
      this.ships.splice(oldpos, 1);
      this.ships.splice(newpos, 0, selectedShip);
      this.updatePermaLink;
      if (oldpos !== newpos) {
        this.current_squad.dirty = true;
        return this.container.trigger('xwing-backend:squadDirtinessChanged');
      }
    }

    updatePermaLink() {
      var next_params;
      if (!this.container.is(':visible')) { // gross but couldn't make clearInterval work
        return;
      }
      next_params = this.getPermaLinkParams();
      if (window.location.search !== next_params) {
        return window.history.replaceState(next_params, '', this.getPermaLink(next_params));
      }
    }

    onNotesUpdated() {
      if (this.total_points > 0) {
        this.current_squad.dirty = true;
        return this.container.trigger('xwing-backend:squadDirtinessChanged');
      }
    }

    onGameTypeChanged(gametype, cb = $.noop) {
      var j, len, oldQuickbuild, old_id, ref, ref1, ship;
      oldQuickbuild = this.isQuickbuild;
      this.isStandard = false;
      this.isXwa = false;
      this.isEpic = false;
      this.isQuickbuild = false;
      this.epic_not_legal_container.toggleClass('d-none', true);
      switch (gametype) {
        case 'xwa':
          this.isXwa = true;
          this.desired_points_input.val(20);
          break;
        case 'extended':
          this.desired_points_input.val(20);
          break;
        case 'epic':
          this.isEpic = true;
          this.isXwa = true;
          this.desired_points_input.val(20);
          this.epic_not_legal_container.toggleClass('d-none', false);
          break;
        case 'quickbuild':
          this.isQuickbuild = true;
          this.desired_points_input.val(8);
          break;
        default:
          this.isStandard = true;
          this.desired_points_input.val(20);
      }
      if (oldQuickbuild !== this.isQuickbuild) {
        old_id = this.current_squad.id;
        this.newSquadFromScratch($.trim(this.current_squad.name));
        this.current_squad.id = old_id; // we want to keep the ID, so we allow people to use the save button
      } else {
        old_id = this.current_squad.id;
        ref = this.ships;
        for (j = 0, len = ref.length; j < len; j++) {
          ship = ref[j];
          if (ship.pilot != null) {
            ship.setPilotById((ref1 = ship.pilot) != null ? ref1.id : void 0);
          }
        }
        this.container.trigger('xwing:pointsUpdated', $.noop);
        this.container.trigger('xwing:shipUpdated');
      }
      return cb();
    }

    addStandardizedToList(ship) {
      return ship.addStandardizedUpgrades();
    }

    onPointsUpdated(cb = $.noop) {
      var conditions, conditions_set, gamemode, i, j, l, len, points_dest, points_destroyed, points_left, ref, ref1, ship, ship_uses_unreleased_content, tot_points, unreleased_content_used;
      tot_points = 0;
      points_dest = 0;
      unreleased_content_used = false;
// validating may remove the ship, if not only some upgrade, but the pilot himself is not valid. Thus iterate backwards over the array, so that is probably fine?
      for (i = j = ref = this.ships.length - 1; (ref <= -1 ? j < -1 : j > -1); i = ref <= -1 ? ++j : --j) {
        ship = this.ships[i];
        ship.validate();
        if (!ship) { // if the ship has been removed, we no longer care about it
          continue;
        }
        // Standardized Loop, will integrate later for efficiency
        this.addStandardizedToList(ship);
        tot_points += ship.getPoints();
        if (ship.destroystate === 1) {
          points_dest += Math.floor(ship.getPoints() / 2);
        } else if (ship.destroystate === 2) {
          points_dest += ship.getPoints();
        }
        ship_uses_unreleased_content = ship.checkUnreleasedContent();
        if (ship_uses_unreleased_content) {
          unreleased_content_used = ship_uses_unreleased_content;
        }
      }
      this.total_points = tot_points;
      this.points_destroyed = points_dest;
      this.total_points_span.text(this.total_points);
      points_left = parseInt(this.desired_points_input.val()) - this.total_points;
      points_destroyed = parseInt(this.total_points);
      this.points_remaining_span.text(points_left);
      this.points_destroyed_span.html(points_dest !== 0 ? `<i class="xwing-miniatures-font xwing-miniatures-font-hit"></i>${points_dest}` : "");
      this.points_remaining_container.toggleClass('red', points_left < 0);
      this.unreleased_content_used_container.toggleClass('d-none', !unreleased_content_used);
      if (this.isStandard === false) {
        gamemode = "(Extended)";
      } else {
        gamemode = "(Standard)";
      }
      if (this.isXwa) {
        gamemode = "(XWA)";
      }
      if (this.isEpic) {
        gamemode = "(Epic)";
      }
      this.fancy_total_points_container.text(`(${this.total_points}) ${gamemode}`);
      
      // update text list
      this.updatePrintAndExportTexts();
      // console.log "#{@faction}: Squad updated, checking collection"
      this.checkCollection();
      // update conditions used
      // this old version of phantomjs i'm using doesn't support Set
      if (typeof Set !== "undefined" && Set !== null) {
        conditions_set = new Set();
        ref1 = this.ships;
        for (l = 0, len = ref1.length; l < len; l++) {
          ship = ref1[l];
          // shouldn't there be a set union
          ship.getConditions().forEach(function(condition) {
            return conditions_set.add(condition);
          });
        }
        conditions = [];
        conditions_set.forEach(function(condition) {
          return conditions.push(condition);
        });
        conditions.sort(function(a, b) {
          if (a.name.canonicalize() < b.name.canonicalize()) {
            return -1;
          } else if (b.name.canonicalize() > a.name.canonicalize()) {
            return 1;
          } else {
            return 0;
          }
        });
        this.condition_container.text('');
        conditions.forEach((condition) => {
          return this.condition_container.append(conditionToHTML(condition));
        });
      }
      return cb(this.total_points);
    }

    onSquadLoadRequested(squad, cb = $.noop) {
      var afterLoading, ref;
      this.current_squad = squad;
      this.backend_delete_list_button.removeClass('disabled');
      this.updateObstacleSelect(this.current_squad.additional_data.obstacles);
      afterLoading = () => {
        var ref, ref1;
        this.notes.val((ref = squad.additional_data.notes) != null ? ref : '');
        this.tag.val((ref1 = squad.additional_data.tag) != null ? ref1 : '');
        this.backend_status.fadeOut('slow');
        this.current_squad.dirty = false;
        this.container.trigger('xwing-backend:squadNameChanged');
        this.container.trigger('xwing-backend:squadDirtinessChanged');
        return cb();
      };
      if (((ref = squad.serialized) != null ? ref.length : void 0) != null) {
        this.loadFromSerialized(squad.serialized, afterLoading);
      }
      return {
        else: afterLoading()
      };
    }

    onSquadDirtinessChanged() {
      //@current_squad.name = $.trim(@squad_name_input.val())
      this.backend_save_list_button.toggleClass('disabled', !(this.current_squad.dirty && this.total_points > 0));
      this.backend_save_list_as_button.toggleClass('disabled', this.total_points === 0);
      this.backend_delete_list_button.toggleClass('disabled', this.current_squad.id == null);
      if (this.ships.length > 1) {
        return $('meta[property="og:description"]').attr("content", this.uitranslation("X-Wing Squadron by YASB: ") + this.current_squad.name + ": " + this.describeSquad());
      } else {
        return $('meta[property="og:description"]').attr("content", this.uitranslation("YASB advertisment"));
      }
    }

    onSquadNameChanged() {
      var short_name;
      if (this.current_squad.name.length > SQUAD_DISPLAY_NAME_MAX_LENGTH) {
        short_name = `${this.current_squad.name.substr(0, SQUAD_DISPLAY_NAME_MAX_LENGTH)}&hellip;`;
      } else {
        short_name = this.current_squad.name;
      }
      this.squad_name_placeholder.text('');
      this.squad_name_placeholder.append(short_name);
      this.squad_name_input.val(this.current_squad.name);
      if ($.getParameterByName('f') !== this.faction) {
        return;
      }
      if (this.current_squad.name !== this.uitranslation("Unnamed Squadron") && this.current_squad.name !== this.uitranslation("Unsaved Squadron")) {
        if (document.title !== "YASB - " + this.current_squad.name) {
          document.title = "YASB - " + this.current_squad.name;
        }
      } else {
        document.title = "YASB";
      }
      return this.updatePrintAndExportTexts();
    }

    updatePrintAndExportTexts() {
      var j, l, len, len1, obstacle, obstacles, reddit_ships, ref, ship, simplecopy_ships, tts_obstacles, tts_ships;
      // update text list
      this.fancy_container.text('');
      this.simple_container.html('<table class="simple-table"></table>');
      simplecopy_ships = [];
      reddit_ships = [];
      tts_ships = [];
      ref = this.ships;
      for (j = 0, len = ref.length; j < len; j++) {
        ship = ref[j];
        if (ship.pilot != null) {
          this.fancy_container.append(ship.toHTML());
          
          //for dial in @fancy_container.find('.fancy-dial')
          //dial.hidden = true
          this.simple_container.find('table').append(ship.toTableRow());
          simplecopy_ships.push(ship.toSimpleCopy());
          reddit_ships.push(ship.toRedditText());
          tts_ships.push(ship.toTTSText());
        }
      }
      this.reddit_container.find('textarea').val($.trim(`${reddit_ships.join("    \n")}    \n**${this.uitranslation('Total')}:** *${this.total_points}*    \n    \n[${this.uitranslation('View in YASB')}](${this.getPermaLink()})`));
      this.simplecopy_container.find('textarea').val($.trim(`${simplecopy_ships.join("")}    \n${this.uitranslation('Total')}: ${this.total_points}    \n    \n${this.uitranslation('View in YASB')}: ${this.getPermaLink()}`));
      
      //Additional code to add obstacles to TTS
      obstacles = this.getObstacles();
      if (((obstacles != null) && obstacles.length > 0) && (tts_ships.length > 0)) {
        tts_ships[tts_ships.length - 1] = tts_ships[tts_ships.length - 1].slice(0, -2);
        tts_obstacles = ' |';
        for (l = 0, len1 = obstacles.length; l < len1; l++) {
          obstacle = obstacles[l];
          if (obstacle != null) {
            tts_obstacles += ` ${obstacle} /`;
          }
        }
        tts_obstacles = tts_obstacles.slice(0, -1);
        tts_ships.push(tts_obstacles);
      }
      this.tts_textarea.val($.trim(`${tts_ships.join("")}`));
      this.xws_textarea.val($.trim(JSON.stringify(this.toXWS())));
      $('#xws-qrcode-container').text('');
      return $('#xws-qrcode-container').qrcode({
        render: 'canvas',
        text: JSON.stringify(this.toMinimalXWS()),
        ec: 'L',
        size: 128
      });
    }

    removeAllShips() {
      while (this.ships.length > 0) {
        this.removeShip(this.ships[0]);
      }
      if (this.ships.length > 0) {
        throw new Error(this.uitranslation("Ships not emptied"));
      }
    }

    showTextListModal() {
      // Display print/text view modal
      return this.list_modal.modal('show');
    }

    showXWSModal(xws) {
      // Display xws view modal
      this.select_xws_view();
      return this.showTextListModal();
    }

    showChooseObstaclesModal() {
      this.obstacles_select.select2('val', this.current_squad.additional_data.obstacles);
      return this.choose_obstacles_modal.modal('show');
    }

    showObstaclesSelectInfo() {
      var j, len, newtext, obstacle, obstacle_array, ref, ref1, ref2, sources;
      obstacle_array = this.obstacles_select.val().split(",");
      if (obstacle_array !== []) {
        newtext = "";
        for (j = 0, len = obstacle_array.length; j < len; j++) {
          obstacle = obstacle_array[j];
          sources = (ref = (ref1 = exportObj.obstacles[obstacle]) != null ? ref1.sources : void 0) != null ? ref : [];
          newtext += `<u>${obstacle}</u>: ${((sources.length > 1) || (!(ref2 = exportObj.translate('sources', 'Loose Ships'), indexOf.call(sources, ref2) >= 0)) ? (sources.length > 0 ? sources.join(', ') : exportObj.translate('ui', 'unreleased')) : this.uitranslation("Only available from 1st edition"))}</br>`;
        }
        return this.obstacles_select_sources.html($.trim(newtext));
      } else {
        return this.obstacles_select_sources.html('');
      }
    }

    updateObstacleSelect(obstacles) {
      this.current_obstacles = obstacles != null ? obstacles : [];
      this.obstacles_select.select2('val', obstacles);
      return this.showObstaclesSelectInfo();
    }

    serialize() {
      var game_type_abbrev, selected_points, serialization_version, ship;
      serialization_version = 9;
      game_type_abbrev = (function() {
        switch (this.game_type_selector.val()) {
          case 'standard':
            return 'h';
          case 'extended':
            return 's';
          case 'xwa':
            return 'b';
          case 'epic':
            return 'e';
          case 'quickbuild':
            return 'q';
        }
      }).call(this);
      selected_points = $.trim(this.desired_points_input.val());
      return `v${serialization_version}Z${game_type_abbrev}Z${selected_points}Z${((function() {
        var j, len, ref, results1;
        ref = this.ships;
        results1 = [];
        for (j = 0, len = ref.length; j < len; j++) {
          ship = ref[j];
          if ((ship.pilot != null) && (!this.isQuickbuild || ship.primary)) {
            results1.push(ship.toSerialized());
          }
        }
        return results1;
      }).call(this)).join('Y')}`;
    }

    changeGameTypeOnSquadLoad(gametype) {
      if (this.game_type_selector.val() !== gametype) {
        return $(window).trigger('xwing:gameTypeChanged', gametype);
      }
    }

    async loadFromSerialized(serialized, cb = $.noop) {
      var desired_points, g, game_type_abbrev, game_type_and_point_abbrev, j, l, len, len1, matches, new_ship, p, re, ref, s, serialized_ship, serialized_ships, ship, ship_splitter, ships_with_unmet_dependencies, version;
      this.suppress_automatic_new_ship = true;
      // Clear all existing ships
      this.removeAllShips();
      re = indexOf.call(serialized, "Z") >= 0 ? /^v(\d+)Z(.*)/ : /^v(\d+)!(.*)/;
      matches = re.exec(serialized);
      if (matches != null) {
        // versioned
        version = parseInt(matches[1]);
        // v9: X-Wing 2.5 points rework. Due to the massive change in points structure, previous versions will no longer be supported
        ship_splitter = version > 7 ? 'Y' : ';';
        // parse out game type
        [game_type_abbrev, desired_points, serialized_ships] = version > 7 ? ([g, p, s] = matches[2].split('Z'), [g, parseInt(p), s]) : ([game_type_and_point_abbrev, s] = matches[2].split('!'), parseInt(game_type_and_point_abbrev.split('=')[1]) ? p = parseInt(game_type_and_point_abbrev.split('=')[1]) : p = 20, g = game_type_and_point_abbrev.split('=')[0], [g, p, s]);
        if (version < 9) { // old version are no longer supported
          this.old_version_container.toggleClass('d-none', false);
          this.suppress_automatic_new_ship = false;
          this.addShip();
          return;
        }
        if (serialized_ships == null) { // something went wrong, we can't load that serialization
          this.loading_failed_container.toggleClass('d-none', false);
          this.suppress_automatic_new_ship = false;
          this.addShip();
          return;
        }
        this.isCurrentlyLoadingSquad = true;
        switch (game_type_abbrev) {
          case 's':
            this.changeGameTypeOnSquadLoad('extended');
            break;
          case 'h':
            this.changeGameTypeOnSquadLoad('standard');
            break;
          case 'b':
            this.changeGameTypeOnSquadLoad('xwa');
            break;
          case 'e':
            this.changeGameTypeOnSquadLoad('epic');
            break;
          case 'q':
            this.changeGameTypeOnSquadLoad('quickbuild');
        }
        this.desired_points_input.val(desired_points);
        this.desired_points_input.change();
        ships_with_unmet_dependencies = [];
        if (serialized_ships.length != null) {
          ref = serialized_ships.split(ship_splitter);
          for (j = 0, len = ref.length; j < len; j++) {
            serialized_ship = ref[j];
            if (serialized_ship !== '') {
              new_ship = this.addShip();
              // try to create ship. fromSerialized returns false, if some upgrade have been skipped as they are not legal until now (e.g. 0-0-0 but vader is not yet in the squad)
              // if not the entire ship is valid, we'll try again later - but keep the valid part added, so other ships may already see some upgrades
              if ((!(await new_ship.fromSerialized(version, serialized_ship))) || !new_ship.pilot) { // also check, if the pilot has been set (the pilot himself was not invalid)
                ships_with_unmet_dependencies.push([new_ship, serialized_ship]);
              }
            }
          }
          for (l = 0, len1 = ships_with_unmet_dependencies.length; l < len1; l++) {
            ship = ships_with_unmet_dependencies[l];
            // 2nd attempt to load ships with unmet dependencies.
            if (!ship[0].pilot) {
              // create ship, if the ship was so invalid, that it in fact decided to not exist
              ship[0] = this.addShip();
            }
            ship[0].fromSerialized(version, ship[1]);
          }
        }
        this.isCurrentlyLoadingSquad = false;
      }
      this.suppress_automatic_new_ship = false;
      // Finally, the unassigned ship
      this.addShip();
      this.container.trigger('xwing:pointsUpdated');
      return cb();
    }

    select_xws_view() {
      this.select_xws_view_button.blur();
      if (this.list_display_mode !== 'xws') {
        this.list_modal.find('.list-display-mode .btn').removeClass('btn-inverse');
        this.select_xws_view_button.addClass('btn-inverse');
        this.list_display_mode = 'xws';
        this.xws_container.show();
        this.simple_container.hide();
        this.simplecopy_container.hide();
        this.reddit_container.hide();
        this.fancy_container.hide();
        this.tts_container.hide();
        this.xws_textarea.select();
        this.xws_textarea.focus();
        this.toggle_vertical_space_container.hide();
        this.toggle_color_print_container.hide();
        this.toggle_color_skip_text.hide();
        this.toggle_maneuver_dial_container.hide();
        this.toggle_expanded_shield_hull_container.hide();
        this.toggle_qrcode_container.hide();
        this.toggle_obstacle_container.hide();
        return this.btn_print_list.disabled = true;
      }
    }

    uniqueIndex(unique, type) {
      if (!(type in this.uniques_in_use)) {
        throw new Error(`Invalid unique type '${type}'`);
      }
      return this.uniques_in_use[type].indexOf(unique);
    }

    claimUnique(unique, type, cb) {
      var j, l, len, len1, other, ref, ref1;
      if (this.uniqueIndex(unique, type) < 0) {
        ref = exportObj.pilotsByUniqueName[unique.canonical_name.getXWSBaseName()] || [];
        // Claim pilots with the same canonical name
        for (j = 0, len = ref.length; j < len; j++) {
          other = ref[j];
          if (unique !== other) {
            if (this.uniqueIndex(other, 'Pilot') < 0) {
              // console.log "Also claiming unique pilot #{other.canonical_name} in use"
              this.uniques_in_use['Pilot'].push(other);
            } else {
              throw new Error(`Unique ${type} '${unique.name}' already claimed as pilot`);
            }
          }
        }
        ref1 = exportObj.upgradesByUniqueName[unique.canonical_name.getXWSBaseName()] || [];
        for (l = 0, len1 = ref1.length; l < len1; l++) {
          other = ref1[l];
          if (this.uniqueIndex(other, 'Upgrade') < 0) {
            // console.log "Also claiming unique pilot #{other.canonical_name} in use"
            this.uniques_in_use['Upgrade'].push(other);
          } else {
            throw new Error(`Unique ${type} '${other.name}' already claimed as pilot`);
          }
        }
        // Solitary Check
        if (unique.solitary != null) {
          this.uniques_in_use['Slot'].push(unique.slot);
        }
        this.uniques_in_use[type].push(unique);
      } else {
        throw new Error(`Unique ${type} '${unique.name}' already claimed`);
      }
      return cb();
    }

    releaseUnique(unique, type, cb) {
      var idx, j, l, len, len1, ref, u, uniques;
      idx = this.uniqueIndex(unique, type);
      if (idx >= 0) {
        ref = this.uniques_in_use;
        // Release all uniques with the same canonical name and base name
        for (type in ref) {
          uniques = ref[type];
          // Removing stuff in a loop sucks, so we'll construct a new list
          if (type === 'Slot') {
            if (unique.solitary != null) {
              this.uniques_in_use[type] = [];
              for (j = 0, len = uniques.length; j < len; j++) {
                u = uniques[j];
                if (u !== unique.slot) {
                  // Keep this one
                  this.uniques_in_use[type].push(u.slot);
                }
              }
            }
          } else {
            this.uniques_in_use[type] = [];
            for (l = 0, len1 = uniques.length; l < len1; l++) {
              u = uniques[l];
              if (u.canonical_name.getXWSBaseName() !== unique.canonical_name.getXWSBaseName()) {
                // Keep this one
                this.uniques_in_use[type].push(u);
              }
            }
          }
        }
      } else {
        // else
        //     console.log "Releasing #{u.name} (#{type}) with canonical name #{unique.canonical_name}"
        throw new Error(`Unique ${type} '${unique.name}' not in use`);
      }
      return cb();
    }

    addShip() {
      var new_ship;
      new_ship = new Ship({
        builder: this,
        container: this.ship_container
      });
      this.ships.push(new_ship);
      this.ship_number_invalid_container.toggleClass('d-none', this.ships.length < 10 && this.ships.length > 3); // bounds are 2..10 as we always have a "empty" ship at the bottom
      this.multi_faction_warning_container.toggleClass('d-none', this.faction !== "All");
      return new_ship;
    }

    async removeShip(ship, cb = $.noop) {
      if ((ship != null ? ship.destroy : void 0) != null) {
        await new Promise((resolve, reject) => {
          return ship.destroy(resolve);
        });
        await new Promise((resolve, reject) => {
          return this.container.trigger('xwing:pointsUpdated', resolve);
        });
        this.current_squad.dirty = true;
        this.container.trigger('xwing-backend:squadDirtinessChanged');
        this.ship_number_invalid_container.toggleClass('d-none', this.ships.length < 10 && this.ships.length > 3);
        this.multi_faction_warning_container.toggleClass('d-none', this.faction !== "All");
      }
      return cb();
    }

    matcher(item, term) {
      return item.toUpperCase().indexOf(term.toUpperCase()) >= 0;
    }

    isOurFaction(faction, alt_faction = '') {
      var check_faction, f, j, len;
      check_faction = this.faction;
      if (this.faction === "All") {
        if (alt_faction !== '') {
          check_faction = alt_faction;
        } else {
          return true;
        }
      }
      if (faction instanceof Array) {
        for (j = 0, len = faction.length; j < len; j++) {
          f = faction[j];
          if (getPrimaryFaction(f) === check_faction) {
            return true;
          }
        }
        return false;
      } else {
        return getPrimaryFaction(faction) === check_faction;
      }
    }

    isItemAvailable(item_data, shipCheck = false) {
      var ref, ref1;
      // this method is not even invoked by most quickbuild stuff to check availability for quickbuild squads, as the method was formerly just telling apart extended/standard
      if (this.isQuickbuild) {
        return true;
      } else if (this.isStandard) {
        return exportObj.standardCheck(item_data, this.faction, shipCheck);
      } else if (!this.isEpic) {
        if ((((ref = exportObj.settings) != null ? ref.ban_list : void 0) != null) && exportObj.settings.ban_list) {
          if (!exportObj.standardCheck(item_data, this.faction, shipCheck, true)) {
            return false;
          }
        }
        return exportObj.epicExclusions(item_data);
      } else {
        if ((((ref1 = exportObj.settings) != null ? ref1.ban_list : void 0) != null) && exportObj.settings.ban_list) {
          if (!exportObj.standardCheck(item_data, this.faction, shipCheck, true)) {
            return false;
          }
        }
        return true;
      }
    }

    getAvailableShipsMatching(term = '', sorted = true, collection_only = false) {
      var ref, ship_data, ship_name, ships;
      ships = [];
      ref = exportObj.ships;
      for (ship_name in ref) {
        ship_data = ref[ship_name];
        if (this.isOurFaction(ship_data.factions) && (this.matcher(ship_data.name, term) || (ship_data.display_name && this.matcher(ship_data.display_name, term)))) {
          if (this.isItemAvailable(ship_data, true)) {
            if (!collection_only || ((this.collection != null) && (this.collection.checks.collectioncheck === "true") && this.collection.checkShelf('ship', ship_data.name))) {
              ships.push({
                id: ship_data.name,
                text: ship_data.display_name ? ship_data.display_name : ship_data.name,
                chassis: ship_data.chassis,
                name: ship_data.name,
                display_name: ship_data.display_name,
                canonical_name: ship_data.canonical_name,
                xws: ship_data.name.canonicalize(),
                icon: ship_data.icon ? ship_data.icon : ship_data.name.canonicalize()
              });
            }
          }
        }
      }
      if (sorted) {
        ships.sort(exportObj.sortHelper);
      }
      return ships;
    }

    getAvailableShipsMatchingAndCheapEnough(points, term = '', sorted = false, collection_only = false) {
      var cheap_ships, j, len, pilots, possible_ships, ship;
      // returns a list of ships that have at least one pilot cheaper than the given points value
      possible_ships = this.getAvailableShipsMatching(term, sorted, collection_only);
      cheap_ships = [];
      for (j = 0, len = possible_ships.length; j < len; j++) {
        ship = possible_ships[j];
        pilots = this.getAvailablePilotsForShipIncluding(ship.name, null, '', true);
        if (pilots.length && pilots[0].points <= points) {
          cheap_ships.push(ship);
        }
      }
      return cheap_ships;
    }

    getAvailablePilotsForShipIncluding(ship, include_pilot, term = '', sorted = true, ship_selector = null) {
      var allowed_quickbuilds_containing_uniques_in_use, available_faction_pilots, eligible_faction_pilots, id, include_pilot_pilot, include_quickbuild, include_upgrade, include_upgrade_name, j, l, len, len1, len2, m, other, pilot, pilot_name, quickbuild, quickbuilds_matching_ship_and_faction, ref, ref1, ref2, ref3, retval, uniques_in_use_by_pilot_in_use, upgrade, upgradedata;
      // Returns data formatted for Select2
      retval = [];
      if (!this.isQuickbuild) {
        // select available pilots according to ususal pilot selection
        available_faction_pilots = (function() {
          var ref, results1;
          ref = exportObj.pilots;
          results1 = [];
          for (pilot_name in ref) {
            pilot = ref[pilot_name];
            if (((ship == null) || pilot.ship === ship) && this.isOurFaction(pilot.faction) && (this.matcher(pilot_name, term) || (pilot.display_name && this.matcher(pilot.display_name, term))) && (this.isItemAvailable(pilot, true))) {
              results1.push(pilot);
            }
          }
          return results1;
        }).call(this);
        eligible_faction_pilots = (function() {
          var results1;
          results1 = [];
          for (pilot_name in available_faction_pilots) {
            pilot = available_faction_pilots[pilot_name];
            if (((pilot.unique == null) || indexOf.call(this.uniques_in_use['Pilot'], pilot) < 0 || pilot.canonical_name.getXWSBaseName() === (include_pilot != null ? include_pilot.canonical_name.getXWSBaseName() : void 0)) && ((pilot.max_per_squad == null) || this.countPilots(pilot.canonical_name) < pilot.max_per_squad || pilot.canonical_name.getXWSBaseName() === (include_pilot != null ? include_pilot.canonical_name.getXWSBaseName() : void 0)) && ((pilot.upgrades == null) || this.standard_restriction_check(pilot, include_pilot)) && ((pilot.restriction_func == null) || pilot.restriction_func({
              builder: this
            }, pilot))) {
              results1.push(pilot);
            }
          }
          return results1;
        }).call(this);
        // Re-add selected pilot
        if ((include_pilot != null) && (include_pilot.unique != null) && (this.matcher(include_pilot.name, term) || (include_pilot.display_name && this.matcher(include_pilot.display_name, term)))) {
          eligible_faction_pilots.push(include_pilot);
        }
        retval = (function() {
          var j, len, ref, results1;
          results1 = [];
          for (j = 0, len = available_faction_pilots.length; j < len; j++) {
            pilot = available_faction_pilots[j];
            results1.push({
              id: pilot.id,
              text: `${(((ref = exportObj.settings) != null ? ref.initiative_prefix : void 0) != null) && exportObj.settings.initiative_prefix ? pilot.skill + ' - ' : ''}${pilot.display_name ? pilot.display_name : pilot.name} (${(this.isXwa && (pilot.pointsxwa != null)) ? pilot.pointsxwa : pilot.points}${pilot.loadout != null ? ((this.isXwa && (pilot.loadoutxwa != null)) ? `/${pilot.loadoutxwa}` : `/${pilot.loadout}`) : ""})`,
              points: ((this.isXwa && (pilot.pointsxwa != null)) ? pilot.pointsxwa : pilot.points),
              ship: pilot.ship,
              name: pilot.name,
              display_name: pilot.display_name,
              disabled: indexOf.call(eligible_faction_pilots, pilot) < 0
            });
          }
          return results1;
        }).call(this);
      } else {
        // select according to quickbuild cards
        // filter for faction and ship
        quickbuilds_matching_ship_and_faction = (function() {
          var ref, results1;
          ref = exportObj.quickbuildsById;
          results1 = [];
          for (id in ref) {
            quickbuild = ref[id];
            if (((ship == null) || quickbuild.ship === ship) && this.isOurFaction(quickbuild.faction) && (this.matcher(quickbuild.pilot, term) || ((exportObj.pilots[quickbuild.pilot].display_name != null) && this.matcher(exportObj.pilots[quickbuild.pilot].display_name, term)))) {
              results1.push(quickbuild);
            }
          }
          return results1;
        }).call(this);
        // create a list of the uniques belonging to the currently selected pilot
        uniques_in_use_by_pilot_in_use = [];
        if ((include_pilot != null) && include_pilot !== -1) {
          include_quickbuild = exportObj.quickbuildsById[include_pilot];
          include_pilot_pilot = exportObj.pilots[include_quickbuild.pilot];
          if (include_pilot_pilot.unique != null) {
            uniques_in_use_by_pilot_in_use.push(include_pilot_pilot);
            ref = exportObj.pilotsByUniqueName[include_pilot_pilot.canonical_name.getXWSBaseName()] || [];
            for (j = 0, len = ref.length; j < len; j++) {
              other = ref[j];
              if (other != null) {
                uniques_in_use_by_pilot_in_use.push(other);
              }
            }
          }
          ref2 = (ref1 = include_quickbuild.upgrades) != null ? ref1 : [];
          for (l = 0, len1 = ref2.length; l < len1; l++) {
            include_upgrade_name = ref2[l];
            include_upgrade = exportObj.upgrades[include_upgrade_name];
            if (include_upgrade.unique != null) {
              uniques_in_use_by_pilot_in_use.push(other);
              ref3 = exportObj.pilotsByUniqueName[include_upgrade.canonical_name.getXWSBaseName()] || [];
              for (m = 0, len2 = ref3.length; m < len2; m++) {
                other = ref3[m];
                if (other != null) {
                  uniques_in_use_by_pilot_in_use.push(other);
                }
              }
            }
            if (include_upgrade.solitary != null) {
              uniques_in_use_by_pilot_in_use.push(include_upgrade.slot);
            }
          }
        }
        // we should also add upgrades with the same unique name like some selected upgrades or the pilot. However, finding them is teadious
        // we should also add uniques used by a linked ship. however, while it is easy to allow selecting them, it is harder to properly add them - as one need to make sure the order of selecting ship + linked ship matters

        // filter for uniques in use
        allowed_quickbuilds_containing_uniques_in_use = [];
        ({
          loop: (function() {
            var ref4, ref5, ref6, ref7, ref8, results1;
            results1 = [];
            for (id in quickbuilds_matching_ship_and_faction) {
              quickbuild = quickbuilds_matching_ship_and_faction[id];
              if ((((ref4 = exportObj.pilots[quickbuild.pilot]) != null ? ref4.unique : void 0) != null) && (ref5 = exportObj.pilots[quickbuild.pilot], indexOf.call(this.uniques_in_use.Pilot, ref5) >= 0) && !(ref6 = exportObj.pilots[quickbuild.pilot], indexOf.call(uniques_in_use_by_pilot_in_use, ref6) >= 0)) {
                allowed_quickbuilds_containing_uniques_in_use.push(quickbuild.id);
                continue;
              }
              if ((((ref7 = exportObj.pilots[quickbuild.pilot]) != null ? ref7.max_per_squad : void 0) != null) && this.countPilots(exportObj.pilots[quickbuild.pilot].canonical_name) >= exportObj.pilots[quickbuild.pilot].max_per_squad && !(ref8 = exportObj.pilots[quickbuild.pilot], indexOf.call(uniques_in_use_by_pilot_in_use, ref8) >= 0)) {
                allowed_quickbuilds_containing_uniques_in_use.push(quickbuild.id);
                continue;
              }
              if (quickbuild.upgrades != null) {
                results1.push((function() {
                  var len3, o, ref10, ref11, ref12, ref13, ref9, results2;
                  ref9 = quickbuild.upgrades;
                  results2 = [];
                  for (o = 0, len3 = ref9.length; o < len3; o++) {
                    upgrade = ref9[o];
                    upgradedata = exportObj.upgrades[upgrade];
                    if (upgradedata == null) {
                      console.log("There was an Issue including the upgrade " + upgrade + " in some quickbuild. Please report that Issue!");
                      continue;
                    }
                    if ((upgradedata.unique != null) && indexOf.call(this.uniques_in_use.Upgrade, upgradedata) >= 0 && !(indexOf.call(uniques_in_use_by_pilot_in_use, upgradedata) >= 0)) {
                      // check, if unique is used by this ship or it's linked ship
                      if (ship_selector === null || !(indexOf.call(exportObj.quickbuildsById[ship_selector.quickbuildId].upgrades, upgrade) >= 0 || (ship_selector.linkedShip && indexOf.call((ref10 = exportObj.quickbuildsById[(ref11 = ship_selector.linkedShip) != null ? ref11.quickbuildId : void 0].upgrades) != null ? ref10 : [], upgrade) >= 0))) {
                        allowed_quickbuilds_containing_uniques_in_use.push(quickbuild.id);
                        break;
                      }
                    }
                    // check if solitary type is already claimed
                    if ((upgradedata.solitary != null) && (ref12 = upgradedata.slot, indexOf.call(this.uniques_in_use['Slot'], ref12) >= 0) && !(ref13 = upgradedata.slot, indexOf.call(uniques_in_use_by_pilot_in_use, ref13) >= 0)) {
                      allowed_quickbuilds_containing_uniques_in_use.push(quickbuild.id);
                      break;
                    } else {
                      results2.push(void 0);
                    }
                  }
                  return results2;
                }).call(this));
              } else {
                results1.push(void 0);
              }
            }
            return results1;
          }).call(this)
        });
        retval = (function() {
          var len3, o, ref4, ref5, results1;
          results1 = [];
          for (o = 0, len3 = quickbuilds_matching_ship_and_faction.length; o < len3; o++) {
            quickbuild = quickbuilds_matching_ship_and_faction[o];
            results1.push({
              id: quickbuild.id,
              text: `${(((ref4 = exportObj.settings) != null ? ref4.initiative_prefix : void 0) != null) && exportObj.settings.initiative_prefix ? exportObj.pilots[quickbuild.pilot].skill + ' - ' : ''}${exportObj.pilots[quickbuild.pilot].display_name ? exportObj.pilots[quickbuild.pilot].display_name : quickbuild.pilot}${quickbuild.suffix} (${quickbuild.threat})`,
              points: quickbuild.threat,
              ship: quickbuild.ship,
              disabled: (ref5 = quickbuild.id, indexOf.call(allowed_quickbuilds_containing_uniques_in_use, ref5) >= 0)
            });
          }
          return results1;
        })();
      }
      if (sorted) {
        retval = retval.sort(exportObj.sortHelper);
      }
      return retval;
    }

    standard_restriction_check(pilot, set_pilot) {
      var j, l, len, len1, len2, m, ref, ref1, ref2, ref3, ref4, ship, shipupgrade, upgrade, upgrade_data;
      if (pilot.upgrades != null) {
        ref = pilot.upgrades;
        for (j = 0, len = ref.length; j < len; j++) {
          upgrade = ref[j];
          upgrade_data = exportObj.upgrades[upgrade];
          if (upgrade_data.unique != null) {
            ref1 = this.ships;
            for (l = 0, len1 = ref1.length; l < len1; l++) {
              ship = ref1[l];
              if (!((((ref2 = ship.pilot) != null ? ref2.name : void 0) != null) && ((set_pilot != null ? set_pilot.name : void 0) != null) && ship.pilot.name === set_pilot.name)) {
                ref3 = ship.upgrades;
                for (m = 0, len2 = ref3.length; m < len2; m++) {
                  shipupgrade = ref3[m];
                  if ((shipupgrade != null ? (ref4 = shipupgrade.data) != null ? ref4.canonical_name : void 0 : void 0) === upgrade_data.canonical_name) {
                    return false;
                  }
                }
              }
            }
          }
        }
      }
      return true;
    }

    countUpgrades(canonical_name) {
      var count, j, l, len, len1, ref, ref1, ref2, ref3, ship, upgrade;
      // returns number of upgrades with given canonical name equipped
      count = 0;
      ref = this.ships;
      for (j = 0, len = ref.length; j < len; j++) {
        ship = ref[j];
        if (((ref1 = ship.pilot) != null ? ref1.upgrades : void 0) == null) {
          ref2 = ship.upgrades;
          for (l = 0, len1 = ref2.length; l < len1; l++) {
            upgrade = ref2[l];
            if ((upgrade != null ? (ref3 = upgrade.data) != null ? ref3.canonical_name : void 0 : void 0) === canonical_name) {
              count++;
            }
          }
        }
      }
      return count;
    }

    countPilots(canonical_name) {
      var count, j, len, ref, ref1, ship;
      // returns number of pilots with given canonical name
      count = 0;
      ref = this.ships;
      for (j = 0, len = ref.length; j < len; j++) {
        ship = ref[j];
        if ((ship != null ? (ref1 = ship.pilot) != null ? ref1.canonical_name.getXWSBaseName() : void 0 : void 0) === canonical_name.getXWSBaseName()) {
          count++;
        }
      }
      return count;
    }

    isShip(ship, name) {
      var f, j, len;
      // console.log "returning #{f} #{name}"
      if (ship instanceof Array) {
        for (j = 0, len = ship.length; j < len; j++) {
          f = ship[j];
          if (f === name) {
            return true;
          }
        }
        return false;
      } else {
        return ship === name;
      }
    }

    getAvailableUpgradesIncluding(slot, include_upgrade, ship, this_upgrade_obj, term = '', filter_func = this.dfl_filter_func, sorted = true) {
      var available_upgrades, eligible_upgrades, equipped_upgrade, j, l, len, len1, points_without_include_upgrade, ref, results1, retval, upgrade, upgrade_name, upgrades_in_use;
      // Returns data formatted for Select2
      upgrades_in_use = (function() {
        var j, len, ref, results1;
        ref = ship.upgrades;
        results1 = [];
        for (j = 0, len = ref.length; j < len; j++) {
          upgrade = ref[j];
          results1.push(upgrade.data);
        }
        return results1;
      })();
      available_upgrades = (function() {
        var ref, results1;
        ref = exportObj.upgrades;
        results1 = [];
        for (upgrade_name in ref) {
          upgrade = ref[upgrade_name];
          if (exportObj.slotsMatching(upgrade.slot, slot) && (this.matcher(upgrade_name, term) || (upgrade.display_name && this.matcher(upgrade.display_name, term))) && ((upgrade.ship == null) || this.isShip(upgrade.ship, ship.data.name)) && ((upgrade.faction == null) || this.isOurFaction(upgrade.faction, ship.pilot.faction)) && (this.isItemAvailable(upgrade)) && (upgrade.standard == null)) {
            results1.push(upgrade);
          }
        }
        return results1;
      }).call(this);
      // available_upgrades = (upgrade for upgrade_name, upgrade of exportObj.upgrades when exportObj.slotsMatching(upgrade.slot, slot) and ( @matcher(upgrade_name, term) or (upgrade.display_name and @matcher(upgrade.display_name, term)) ) and (not upgrade.ship? or @isShip(upgrade.ship, ship.data.name)) and (not upgrade.faction? or ((@faction != "All") and @isOurFaction(upgrade.faction)) or ((@faction == "All") and (not ship.pilot? or (ship.pilot.faction == upgrade.faction)))) and (@isItemAvailable(upgrade)))
      if (filter_func !== this.dfl_filter_func) {
        available_upgrades = (function() {
          var j, len, results1;
          results1 = [];
          for (j = 0, len = available_upgrades.length; j < len; j++) {
            upgrade = available_upgrades[j];
            if (filter_func(upgrade)) {
              results1.push(upgrade);
            }
          }
          return results1;
        })();
      }
      points_without_include_upgrade = ship.upgrade_points_total - this_upgrade_obj.getPoints(include_upgrade);
      eligible_upgrades = (function() {
        var ref, results1;
        results1 = [];
        for (upgrade_name in available_upgrades) {
          upgrade = available_upgrades[upgrade_name];
          if ((indexOf.call(this.uniques_in_use['Upgrade'], upgrade) < 0) && ship.standardized_check(upgrade) && ship.restriction_check(((ship.builder.isXwa && (upgrade.restrictionsxwa != null)) ? upgrade.restrictionsxwa : (upgrade.restrictions ? upgrade.restrictions : void 0)), this_upgrade_obj, this_upgrade_obj.getPoints(upgrade), points_without_include_upgrade, upgrade) && indexOf.call(upgrades_in_use, upgrade) < 0 && ((upgrade.max_per_squad == null) || ship.builder.countUpgrades(upgrade.canonical_name) < upgrade.max_per_squad) && ((upgrade.solitary == null) || ((ref = upgrade.slot, indexOf.call(this.uniques_in_use['Slot'], ref) < 0) || ((include_upgrade != null ? include_upgrade.solitary : void 0) != null)))) {
            results1.push(upgrade);
          }
        }
        return results1;
      }).call(this);
      ref = (function() {
        var l, len, ref, results1;
        ref = ship.upgrades;
        results1 = [];
        for (l = 0, len = ref.length; l < len; l++) {
          upgrade = ref[l];
          if ((upgrade != null ? upgrade.data : void 0) != null) {
            results1.push(upgrade.data);
          }
        }
        return results1;
      })();
      for (j = 0, len = ref.length; j < len; j++) {
        equipped_upgrade = ref[j];
        eligible_upgrades.removeItem(equipped_upgrade);
      }
      // Re-enable selected upgrade
      if ((include_upgrade != null) && (this.matcher(include_upgrade.name, term) || (include_upgrade.display_name && this.matcher(include_upgrade.display_name, term)))) {
        eligible_upgrades.push(include_upgrade);
      }
      retval = (function() {
        var l, len1, results1;
        results1 = [];
        for (l = 0, len1 = available_upgrades.length; l < len1; l++) {
          upgrade = available_upgrades[l];
          results1.push({
            id: upgrade.id,
            text: `${upgrade.display_name ? upgrade.display_name : upgrade.name} (${this_upgrade_obj.getPoints(upgrade)}${upgrade.variablepoints ? '*' : ''})`,
            points: this_upgrade_obj.getPoints(upgrade),
            name: upgrade.name,
            display_name: upgrade.display_name,
            disabled: indexOf.call(eligible_upgrades, upgrade) < 0
          });
        }
        return results1;
      })();
      if (sorted) {
        retval = retval.sort(exportObj.sortHelper);
      }
      if (typeof this_upgrade_obj === "function" ? this_upgrade_obj(typeof adjustment_func !== "undefined" && adjustment_func !== null) : void 0) {
        results1 = [];
        for (l = 0, len1 = retval.length; l < len1; l++) {
          upgrade = retval[l];
          results1.push(this_upgrade_obj.adjustment_func(upgrade));
        }
        return results1;
      } else {
        return retval;
      }
    }

    getSquadDialsAsHTML() {
      var added_dials, dialHTML, j, len, maneuvers_modified, maneuvers_unmodified, ref, ref1, ref2, ship;
      dialHTML = "";
      added_dials = {};
      ref = this.ships;
      for (j = 0, len = ref.length; j < len; j++) {
        ship = ref[j];
        if (ship.pilot != null) {
          maneuvers_unmodified = ship.data.maneuvers;
          maneuvers_modified = ship.effectiveStats().maneuvers;
          if ((added_dials[ship.data.name] == null) || !(ref1 = maneuvers_modified.toString(), indexOf.call(added_dials[ship.data.name], ref1) >= 0)) {
            added_dials[ship.data.name] = ((ref2 = added_dials[ship.data.name]) != null ? ref2 : []).concat([maneuvers_modified.toString()]); // save maneuver as string, as that is easier to compare than arrays (if e.g. two ships of same type, one with and one without R4 are in a squad, we add 2 dials)
            dialHTML += '<div class="fancy-dial">' + `<h4 class="ship-name-dial">${ship.data.display_name != null ? ship.data.display_name : ship.data.name}` + `${maneuvers_modified.toString() !== maneuvers_unmodified.toString() ? " (" + this.uitranslation("modified") + ")" : ""}</h4>` + this.getManeuverTableHTML(maneuvers_modified, maneuvers_unmodified) + '</div>';
          } // There is always one "empty" ship at the bottom of each squad, that we want to skip. 
        }
      }
      return `<div class="print-dials-container">
    ${dialHTML}
</div>`;
    }

    // dialHTML = @builder.getManeuverTableHTML(effective_stats.maneuvers, @data.maneuvers)

      // Converts a maneuver table for into an HTML table.
    getManeuverTableHTML(maneuvers, baseManeuvers) {
      var bearing, bearings, bearings_without_maneuvers, className, color, difficulty, haveManeuver, innerPath, j, l, len, len1, len2, linePath, m, maneuverClass, maneuverClass2, o, outTable, outlineColor, q, ref, ref1, ref2, ref3, speed, transform, trianglePath, turn, v;
      if ((maneuvers == null) || maneuvers.length === 0) {
        return this.uitranslation("Missing maneuver info.");
      }
      // Preprocess maneuvers to see which bearings are never used so we
      // don't render them.
      bearings_without_maneuvers = (function() {
        var results1 = [];
        for (var j = 0, ref = maneuvers[0].length; 0 <= ref ? j < ref : j > ref; 0 <= ref ? j++ : j--){ results1.push(j); }
        return results1;
      }).apply(this);
      for (j = 0, len = maneuvers.length; j < len; j++) {
        bearings = maneuvers[j];
        for (bearing = l = 0, len1 = bearings.length; l < len1; bearing = ++l) {
          difficulty = bearings[bearing];
          if (difficulty > 0) {
            bearings_without_maneuvers.removeItem(bearing);
          }
        }
      }
      // console.log "bearings without maneuvers:"
      // console.dir bearings_without_maneuvers
      outTable = "<table><tbody>";
      for (speed = m = ref1 = maneuvers.length - 1; (ref1 <= 0 ? m <= 0 : m >= 0); speed = ref1 <= 0 ? ++m : --m) {
        haveManeuver = false;
        ref2 = maneuvers[speed];
        for (o = 0, len2 = ref2.length; o < len2; o++) {
          v = ref2[o];
          if (v > 0) {
            haveManeuver = true;
            break;
          }
        }
        if (!haveManeuver) {
          continue;
        }
        outTable += `<tr><td>${speed}</td>`;
        for (turn = q = 0, ref3 = maneuvers[speed].length; (0 <= ref3 ? q < ref3 : q > ref3); turn = 0 <= ref3 ? ++q : --q) {
          if (indexOf.call(bearings_without_maneuvers, turn) >= 0) {
            continue;
          }
          outTable += "<td>";
          if (maneuvers[speed][turn] > 0) {
            color = (function() {
              switch (maneuvers[speed][turn]) {
                case 1:
                  return "dodgerblue";
                case 2:
                  return "white";
                case 3:
                  return "red";
                case 4:
                  return "purple";
              }
            })();
            // we need this to change the color to b/w in case we want to print b/w
            maneuverClass = (function() {
              switch (maneuvers[speed][turn]) {
                case 1:
                  return "svg-blue-maneuver";
                case 2:
                  return "svg-white-maneuver";
                case 3:
                  return "svg-red-maneuver";
                case 4:
                  return "svg-purple-maneuver";
              }
            })();
            outTable += `<svg xmlns="http://www.w3.org/2000/svg" width="30px" height="30px" viewBox="0 0 200 200">`;
            outlineColor = "black";
            maneuverClass2 = "svg-base-maneuver";
            if (maneuvers[speed][turn] !== baseManeuvers[speed][turn]) {
              outlineColor = "DarkSlateGrey"; // highlight manuevers modified by another card (e.g. R2 Astromech makes all 1 & 2 speed maneuvers green)
              maneuverClass2 = "svg-modified-maneuver";
            }
            if (speed === 0 && turn === 2) {
              outTable += `<rect class="svg-maneuver-stop ${maneuverClass} ${maneuverClass2}" x="50" y="50" width="100" height="100" style="fill:${color}; stroke-width:5; stroke:${outlineColor}" />`;
            } else {
              transform = "";
              className = "";
              switch (turn) {
                case 0:
                  // turn left
                  linePath = "M160,180 L160,70 80,70";
                  innerPath = "M160,175 L160,70 70,70";
                  trianglePath = "M80,100 V40 L30,70 Z";
                  break;
                case 1:
                  // bank left
                  linePath = "M150,180 S150,120 80,60";
                  innerPath = "M150,175 S150,120 80,60";
                  trianglePath = "M80,100 V40 L30,70 Z";
                  transform = "transform='translate(-5 -15) rotate(45 70 90)' ";
                  break;
                case 2:
                  // straight
                  linePath = "M100,180 L100,100 100,80";
                  innerPath = "M100,175 L100,120 100,70";
                  trianglePath = "M70,80 H130 L100,30 Z";
                  break;
                case 3:
                  // bank right
                  linePath = "M50,180 S50,120 120,60";
                  innerPath = "M50,175 S50,120 120,60";
                  trianglePath = "M120,100 V40 L170,70 Z";
                  transform = "transform='translate(5 -15) rotate(-45 130 90)' ";
                  break;
                case 4:
                  // turn right
                  linePath = "M40,180 L40,70 120,70";
                  innerPath = "M40,175 L40,70 130,70";
                  trianglePath = "M120,100 V40 L170,70 Z";
                  break;
                case 5:
                  // k-turn/u-turn
                  linePath = "M50,180 L50,100 C50,10 140,10 140,100 L140,120";
                  innerPath = "M50,175 L50,100 C50,10 140,10 140,100 L140,130";
                  trianglePath = "M170,120 H110 L140,180 Z";
                  break;
                case 6:
                  // segnor's loop left
                  linePath = "M150,180 S150,120 80,60";
                  innerPath = "M150,175 S150,120 85,65";
                  trianglePath = "M80,100 V40 L30,70 Z";
                  transform = "transform='translate(0 50)'";
                  break;
                case 7:
                  // segnor's loop right
                  linePath = "M50,180 S50,120 120,60";
                  innerPath = "M50,175 S50,120 115,65";
                  trianglePath = "M120,100 V40 L170,70 Z";
                  transform = "transform='translate(0 50)'";
                  break;
                case 8:
                  // tallon roll left
                  linePath = "M160,180 L160,70 80,70";
                  innerPath = "M160,175 L160,70 85,70";
                  trianglePath = "M60,100 H100 L80,140 Z";
                  break;
                case 9:
                  // tallon roll right
                  linePath = "M40,180 L40,70 120,70";
                  innerPath = "M40,175 L40,70 115,70";
                  trianglePath = "M100,100 H140 L120,140 Z";
                  break;
                case 10:
                  // backward left
                  linePath = "M50,180 S50,120 120,60";
                  innerPath = "M50,175 S50,120 120,60";
                  trianglePath = "M120,100 V40 L170,70 Z";
                  transform = "transform='translate(5 -15) rotate(-45 130 90)' ";
                  className = 'backwards';
                  break;
                case 11:
                  // backward straight
                  linePath = "M100,180 L100,100 100,80";
                  innerPath = "M100,175 L100,100 100,70";
                  trianglePath = "M70,80 H130 L100,30 Z";
                  className = 'backwards';
                  break;
                case 12:
                  // backward right
                  linePath = "M150,180 S150,120 80,60";
                  innerPath = "M150,175 S150,120 80,60";
                  trianglePath = "M80,100 V40 L30,70 Z";
                  transform = "transform='translate(-5 -15) rotate(45 70 90)' ";
                  className = 'backwards';
              }
              outTable += $.trim(`<g class="maneuver ${className}">
  <path class = 'svg-maneuver-outer ${maneuverClass} ${maneuverClass2}' stroke-width='25' fill='none' stroke='${outlineColor}' d='${linePath}' />
  <path class = 'svg-maneuver-triangle ${maneuverClass} ${maneuverClass2}' d='${trianglePath}' fill='${color}' stroke-width='5' stroke='${outlineColor}' ${transform}/>
  <path class = 'svg-maneuver-inner ${maneuverClass} ${maneuverClass2}' stroke-width='15' fill='none' stroke='${color}' d='${innerPath}' />
</g>`);
            }
            outTable += "</svg>";
          }
          outTable += "</td>";
        }
        outTable += "</tr>";
      }
      outTable += "</tbody></table>";
      return outTable;
    }

    formatActions(actions, seperation, keyword = []) {
      var action, action_icons, actionlist, color, j, len, prefix;
      action_icons = [];
      for (j = 0, len = actions.length; j < len; j++) {
        action = actions[j];
        color = "";
        prefix = seperation;
        if (indexOf.call(keyword, "Droid") >= 0) {
          action = action.replace('Focus', 'Calculate');
        }
        // Search and filter each type of action by its prefix and then reformat it for html
        if (action.search('> ') !== -1) {
          action = action.replace(/> /gi, '');
          prefix = ` <i class="xwing-miniatures-font xwing-miniatures-font-linked"></i> `;
        }
        if (action.search('F-') !== -1) {
          color = "force ";
          action = action.replace(/F-/gi, '');
        }
        if (action.search('W-') !== -1) {
          prefix = "White ";
          action = action.replace(/W-/gi, '');
        } else if (action.search('R-') !== -1) {
          color = "red ";
          action = action.replace(/R-/gi, '');
        }
        action = action.toLowerCase().replace(/[^0-9a-z]/gi, '');
        action_icons.push(`${prefix}<i class="xwing-miniatures-font ${color}xwing-miniatures-font-${action}"></i>`);
      }
      actionlist = action_icons.join('');
      return actionlist.replace(seperation, '');
    }

    listStandardUpgrades(upgrades) {
      var formattedname, j, len, upgrade, upgrade_names;
      upgrade_names = '';
      for (j = 0, len = upgrades.length; j < len; j++) {
        upgrade = upgrades[j];
        formattedname = upgrade.split(" (");
        upgrade_names += ', ' + formattedname[0];
      }
      return upgrade_names.substr(2);
    }

    getPilotsMatchingUpgrade(term = '', sorted = true) {
      var j, len, pilot_data, pilot_name, pilots, ref, ref1, upgrade;
      pilots = [];
      ref = exportObj.pilots;
      for (pilot_name in ref) {
        pilot_data = ref[pilot_name];
        if (pilot_data.upgrades != null) {
          ref1 = pilot_data.upgrades;
          for (j = 0, len = ref1.length; j < len; j++) {
            upgrade = ref1[j];
            if (this.matcher(upgrade, term)) {
              pilots.push({
                id: pilot_data.name,
                name: pilot_data.name,
                display_name: pilot_data.display_name,
                chassis: pilot_data.chassis,
                canonical_name: pilot_data.canonical_name,
                xws: pilot_data.name.canonicalize(),
                icon: pilot_data.icon ? pilot_data.icon : pilot_data.name.canonicalize()
              });
            }
          }
        }
      }
      if (sorted) {
        pilots.sort(exportObj.sortHelper);
      }
      return pilots;
    }

    showTooltip(type, data, additional_opts, container = this.info_container, force_update = false) {
      var addon_count, chargeHTML, chassis_title, cls, count, effective_stats, faction, first, forcerecurring, ini, inis, item, j, l, len, len1, len2, len3, loadout_range_text, m, maneuvers_override, matching_pilots, missingStuffInfoText, name, o, pilot, pilot_count, point_info, point_range_text, points, possible_costs, possible_inis, possible_loadout, recurringicon, ref, ref1, ref10, ref11, ref12, ref13, ref14, ref15, ref16, ref17, ref18, ref19, ref2, ref20, ref21, ref22, ref23, ref24, ref25, ref26, ref27, ref28, ref29, ref3, ref30, ref31, ref32, ref33, ref34, ref35, ref36, ref37, ref38, ref39, ref4, ref40, ref41, ref42, ref43, ref44, ref45, ref46, ref47, ref48, ref49, ref5, ref50, ref51, ref52, ref53, ref54, ref55, ref56, ref57, ref58, ref59, ref6, ref60, ref61, ref62, ref63, ref64, ref65, ref66, ref67, ref68, ref69, ref7, ref70, ref71, ref72, ref73, ref74, ref75, ref76, ref77, ref78, ref79, ref8, ref80, ref81, ref82, ref83, ref84, ref85, ref86, ref87, ref88, ref89, ref9, ref90, ref91, ref92, ref93, ref94, ref95, ref96, ref97, restriction_info, ship, ship_count, slot, slot_types, source, sources, state, uniquedots, upgrade, well;
      if (data !== this.tooltip_currently_displaying || force_update) {
        switch (type) {
          case 'Ship':
            // we get all pilots for the ship, to display stuff like available slots which are treated as pilot properties, not ship properties (which makes sense, as they depend on the pilot, e.g. talent or force slots)
            possible_inis = [];
            possible_costs = [];
            possible_loadout = [];
            slot_types = {}; // one number per slot: 0: not available for that ship. 1: always available for that ship. 2: available for some pilots on that ship. 3: slot two times availabel for that ship 4: slot one or two times available (depending on pilot) 5: slot zero to two times available 6: slot three times available (no mixed-case implemented) -1: undefined
            for (slot in exportObj.upgradesBySlotCanonicalName) {
              slot_types[slot] = -1;
            }
            ref = exportObj.pilots;
            for (name in ref) {
              pilot = ref[name];
              // skip all pilots with wrong ship or faction
              if (pilot.ship !== data.name || !this.isOurFaction(pilot.faction)) {
                continue;
              }
              if (!(ref1 = pilot.skill, indexOf.call(possible_inis, ref1) >= 0)) {
                possible_inis.push(pilot.skill);
              }
              if (this.isXwa && (pilot.pointsxwa != null)) {
                possible_costs.push(pilot.pointsxwa);
              } else {
                possible_costs.push(pilot.points);
              }
              if (this.isXwa && (pilot.loadoutxwa != null)) {
                possible_loadout.push(pilot.loadoutxwa);
              } else {
                if (pilot.loadout != null) {
                  possible_loadout.push(pilot.loadout);
                }
              }
              if (pilot.slots != null) {
                for (slot in slot_types) {
                  state = slot_types[slot];
                  switch (pilot.slots.filter((item) => {
                        return item === slot;
                      }).length) {
                    case 1:
                      switch (state) {
                        case -1:
                          slot_types[slot] = 1;
                          break;
                        case 0:
                          slot_types[slot] = 2;
                          break;
                        case 3:
                          slot_types[slot] = 4;
                      }
                      break;
                    case 0:
                      switch (state) {
                        case -1:
                          slot_types[slot] = 0;
                          break;
                        case 1:
                          slot_types[slot] = 2;
                          break;
                        case 3:
                        case 4:
                          slot_types[slot] = 5;
                      }
                      break;
                    case 2:
                      switch (state) {
                        case -1:
                          slot_types[slot] = 3;
                          break;
                        case 0:
                        case 2:
                          slot_types[slot] = 5;
                          break;
                        case 1:
                          slot_types[slot] = 4;
                      }
                      break;
                    case 3:
                      slot_types[slot] = 6;
                  }
                }
              }
            }
            possible_inis.sort();
            container.find('.info-type').text(exportObj.translate("types", type));
            container.find('.info-name').html(`${data.display_name ? data.display_name : data.name}${exportObj.isReleased(data) ? "" : ` (${this.uitranslation('unreleased')})`}`);
            if (((ref2 = this.collection) != null ? ref2.counts : void 0) != null) {
              ship_count = (ref3 = (ref4 = this.collection.counts) != null ? (ref5 = ref4.ship) != null ? ref5[data.name] : void 0 : void 0) != null ? ref3 : 0;
              container.find('.info-collection').text(this.uitranslation("collectionContentShips", ship_count));
              container.find('.info-collection').show();
            } else {
              container.find('.info-collection').hide();
            }
            first = true;
            inis = String(possible_inis[0]);
            for (j = 0, len = possible_inis.length; j < len; j++) {
              ini = possible_inis[j];
              if (!first) {
                inis += ", " + ini;
              }
              first = false;
            }
            container.find('tr.info-skill td.info-data').text(inis);
            container.find('tr.info-skill').toggle(ini !== void 0);
            // display point range for that ship (and faction) 
            point_range_text = `${Math.min(...possible_costs)} - ${Math.max(...possible_costs)}`;
            container.find('tr.info-points td.info-data').text(point_range_text);
            loadout_range_text = `${Math.min(...possible_loadout)} - ${Math.max(...possible_loadout)}`;
            container.find('tr.info-loadout td.info-data').text(loadout_range_text);
            container.find('tr.info-points').toggle(possible_costs.length > 0);
            container.find('tr.info-loadout').toggle(possible_loadout.length > 0);
            container.find('tr.info-engagement').hide();
            container.find('tr.info-attack td.info-data').text(data.attack);
            container.find('tr.info-attack-bullseye td.info-data').text(data.attackbull);
            container.find('tr.info-attack-fullfront td.info-data').text(data.attackf);
            container.find('tr.info-attack-left td.info-data').text(data.attackl);
            container.find('tr.info-attack-right td.info-data').text(data.attackr);
            container.find('tr.info-attack-back td.info-data').text(data.attackb);
            container.find('tr.info-attack-turret td.info-data').text(data.attackt);
            container.find('tr.info-attack-doubleturret td.info-data').text(data.attackdt);
            container.find('tr.info-attack').toggle(data.attack != null);
            container.find('tr.info-attack-bullseye').toggle(data.attackbull != null);
            container.find('tr.info-attack-fullfront').toggle(data.attackf != null);
            container.find('tr.info-attack-left').toggle(data.attackl != null);
            container.find('tr.info-attack-right').toggle(data.attackr != null);
            container.find('tr.info-attack-back').toggle(data.attackb != null);
            container.find('tr.info-attack-turret').toggle(data.attackt != null);
            container.find('tr.info-attack-doubleturret').toggle(data.attackdt != null);
            container.find('tr.info-ship').hide();
            if (data.base != null) {
              container.find('tr.info-base td.info-data').text(exportObj.translate("gameterms", data.base));
            } else {
              container.find('tr.info-base td.info-data').text(exportObj.translate("gameterms", "Small"));
            }
            container.find('tr.info-base').show();
            container.find('tr.info-faction td.info-data').text([
              (function() {
                var l,
              len1,
              ref6,
              results1;
                ref6 = data.factions;
                results1 = [];
                for (l = 0, len1 = ref6.length; l < len1; l++) {
                  faction = ref6[l];
                  results1.push(exportObj.translate("faction",
              faction));
                }
                return results1;
              })()
            ]);
            container.find('tr.info-faction').hide(); // this information is clear from the context, unless we are in card browser
            container.find('p.info-restrictions').hide();
            ref6 = container.find('tr.info-attack td.info-header i.xwing-miniatures-font')[0].classList;
            for (l = 0, len1 = ref6.length; l < len1; l++) {
              cls = ref6[l];
              if (cls.startsWith('xwing-miniatures-font-attack')) {
                container.find('tr.info-attack td.info-header i.xwing-miniatures-font').removeClass(cls);
              }
            }
            container.find('tr.info-attack td.info-header i.xwing-miniatures-font').addClass((ref7 = data.attack_icon) != null ? ref7 : 'xwing-miniatures-font-attack');
            container.find('tr.info-range').hide();
            container.find('tr.info-agility td.info-data').text(data.agility);
            container.find('tr.info-agility').toggle(data.agility != null);
            container.find('tr.info-hull td.info-data').text(data.hull);
            container.find('tr.info-hull').toggle(data.hull != null);
            recurringicon = '';
            if (data.shieldrecurr != null) {
              count = 0;
              while (count < data.shieldrecurr) {
                recurringicon += '<sup><i class="fas fa-caret-up"></i></sup>';
                ++count;
              }
            }
            container.find('tr.info-shields td.info-data').html(data.shields + recurringicon);
            container.find('tr.info-shields').toggle(data.shields != null);
            recurringicon = '';
            if (data.energyrecurr != null) {
              count = 0;
              while (count < data.energyrecurr) {
                recurringicon += '<sup><i class="fas fa-caret-up"></i></sup>';
                ++count;
              }
            }
            container.find('tr.info-energy td.info-data').html(data.energy + recurringicon);
            container.find('tr.info-energy').toggle(data.energy != null);
            
            // One may want to check for force sensitive pilots and display the possible values here (like done for ini), but I'll skip this for now. 
            container.find('tr.info-force').hide();
            container.find('tr.info-charge').hide();
            container.find('tr.info-actions td.info-data').html(this.formatActions(data.actions, ", ", (ref8 = data.keyword) != null ? ref8 : []));
            container.find('tr.info-actions').show();
            // Display all available slots, put brackets around slots that are only available for some pilots
            container.find('tr.info-upgrades').show();
            container.find('tr.info-upgrades td.info-data').html(((function() {
              var results1;
              results1 = [];
              for (slot in slot_types) {
                state = slot_types[slot];
                results1.push(state === 1 ? exportObj.translate('sloticon', slot) : (state === 2 ? '(' + exportObj.translate('sloticon', slot) + ')' : (state === 3 ? exportObj.translate('sloticon', slot) + exportObj.translate('sloticon', slot) : (state === 4 ? exportObj.translate('sloticon', slot) + '(' + exportObj.translate('sloticon', slot) + ')' : (state === 5 ? '(' + exportObj.translate('sloticon', slot) + exportObj.translate('sloticon', slot) + ')' : (state === 6 ? exportObj.translate('sloticon', slot) + exportObj.translate('sloticon', slot) + exportObj.translate('sloticon', slot) : void 0))))));
              }
              return results1;
            })()).join(' ') || 'None');
            container.find('p.info-text').hide();
            container.find('p.info-chassis').show();
            container.find('p.info-chassis').html(data.chassis != null ? `<strong>${(ref9 = (ref10 = exportObj.chassis[data.chassis]) != null ? ref10.display_name : void 0) != null ? ref9 : data.chassis}:</strong> ${exportObj.chassis[data.chassis].text}` : "");
            container.find('p.info-maneuvers').show();
            container.find('p.info-maneuvers').html(this.getManeuverTableHTML(data.maneuvers, data.maneuvers));
            sources = ((function() {
              var len2, m, ref11, results1;
              ref11 = data.sources;
              results1 = [];
              for (m = 0, len2 = ref11.length; m < len2; m++) {
                source = ref11[m];
                results1.push(exportObj.translate('sources', source));
              }
              return results1;
            })()).sort();
            container.find('.info-sources.info-data').text((sources.length > 1) || (!(ref11 = exportObj.translate('sources', 'Loose Ships'), indexOf.call(sources, ref11) >= 0)) ? (sources.length > 0 ? sources.join(', ') : exportObj.translate('ui', 'unreleased')) : this.uitranslation("Only available from 1st edition"));
            container.find('.info-sources').show();
            break;
          case 'Pilot':
            container.find('.info-type').text(exportObj.translate("types", type));
            container.find('.info-sources.info-data').text(((function() {
              var len2, m, ref12, results1;
              ref12 = data.sources;
              results1 = [];
              for (m = 0, len2 = ref12.length; m < len2; m++) {
                source = ref12[m];
                results1.push(exportObj.translate('sources', source));
              }
              return results1;
            })()).sort().join(', '));
            container.find('.info-sources').show();
            if (((ref12 = this.collection) != null ? ref12.counts : void 0) != null) {
              pilot_count = (ref13 = (ref14 = this.collection.counts) != null ? (ref15 = ref14.pilot) != null ? ref15[data.name] : void 0 : void 0) != null ? ref13 : 0;
              ship_count = (ref16 = (ref17 = this.collection.counts.ship) != null ? ref17[data.ship] : void 0) != null ? ref16 : 0;
              container.find('.info-collection').text(this.uitranslation("collectionContentShipsAndPilots", ship_count, pilot_count));
              container.find('.info-collection').show();
            } else {
              container.find('.info-collection').hide();
            }
            
            // if the pilot is already selected and has uprades, some stats may be modified
            if ((additional_opts != null ? additional_opts.effectiveStats : void 0) != null) {
              effective_stats = additional_opts.effectiveStats();
            }
            //logic to determine how many dots to use for uniqueness
            if (data.unique != null) {
              uniquedots = "&middot;&nbsp;";
            } else if (data.max_per_squad != null) {
              count = 0;
              uniquedots = "";
              while (count < data.max_per_squad) {
                uniquedots = uniquedots.concat("&middot;");
                ++count;
              }
              uniquedots = uniquedots.concat("&nbsp;");
            } else {
              uniquedots = "";
            }
            container.find('.info-name').html(`${uniquedots}${data.display_name ? data.display_name : data.name}${exportObj.isReleased(data) ? "" : ` (${exportObj.translate('ui', 'unreleased')})`}`);
            restriction_info = this.restriction_text(data) + this.upgrade_effect(data);
            if (restriction_info !== '' && data.ship !== "Conversion") {
              container.find('p.info-restrictions').html(restriction_info);
              container.find('p.info-restrictions').show();
            } else {
              container.find('p.info-restrictions').hide();
            }
            container.find('p.info-text').html((ref18 = data.text) != null ? ref18 : '');
            container.find('p.info-text').show();
            ship = exportObj.ships[data.ship];
            if (((effective_stats != null ? effective_stats.chassis : void 0) != null) && (effective_stats.chassis !== "")) {
              chassis_title = effective_stats.chassis;
            } else if (data.chassis != null) {
              chassis_title = data.chassis;
            } else if (ship.chassis != null) {
              chassis_title = ship.chassis;
            } else {
              chassis_title = "";
            }
            if (chassis_title !== "") {
              container.find('p.info-chassis').html(`<strong>${(ref19 = (ref20 = exportObj.chassis[chassis_title]) != null ? ref20.display_name : void 0) != null ? ref19 : chassis_title}:</strong> ${exportObj.chassis[chassis_title].text}`);
              container.find('p.info-chassis').show();
            } else {
              container.find('p.info-chassis').hide();
            }
            container.find('tr.info-ship td.info-data').text(data.ship);
            container.find('tr.info-ship').show();
            container.find('tr.info-faction td.info-data').text(exportObj.translate("faction", data.faction));
            container.find('tr.info-faction').hide(); // this information is clear from the context, unless we are in card browser
            if (ship.base != null) {
              container.find('tr.info-base td.info-data').text(exportObj.translate("gameterms", ship.base));
            } else {
              container.find('tr.info-base td.info-data').text(exportObj.translate("gameterms", "Small"));
            }
            container.find('tr.info-base').show();
            container.find('tr.info-skill td.info-data').text(data.skill);
            container.find('tr.info-skill').toggle(data.skill != null);
            container.find('tr.info-points td.info-data').text((this.isXwa && (data.pointsxwa != null) ? data.pointsxwa : data.points));
            container.find('tr.info-points').show();
            container.find('tr.info-loadout td.info-data').text((this.isXwa && (data.loadoutxwa != null) ? data.loadoutxwa : data.loadout));
            if (data.upgrades != null) {
              container.find('tr.info-loadout').hide();
            } else {
              container.find('tr.info-loadout').show();
            }
            if (data.engagement != null) {
              container.find('tr.info-engagement td.info-data').text(data.engagement);
              container.find('tr.info-engagement').show();
            } else {
              container.find('tr.info-engagement').hide();
            }
            container.find('tr.info-attack td.info-header i.xwing-miniatures-font').addClass((ref21 = ship.attack_icon) != null ? ref21 : 'xwing-miniatures-font-attack');
            container.find('tr.info-attack td.info-data').text(statAndEffectiveStat((ref22 = (ref23 = data.ship_override) != null ? ref23.attack : void 0) != null ? ref22 : ship.attack, effective_stats, 'attack'));
            container.find('tr.info-attack').toggle((((ref24 = (ref25 = data.ship_override) != null ? ref25.attack : void 0) != null ? ref24 : ship.attack) > 0) || (((effective_stats != null ? effective_stats.attack : void 0) != null) && (effective_stats != null ? effective_stats.attack : void 0) > 0));
            container.find('tr.info-attack-fullfront td.info-data').text(statAndEffectiveStat((ref26 = (ref27 = data.ship_override) != null ? ref27.attackf : void 0) != null ? ref26 : ship.attackf, effective_stats, 'attackf'));
            container.find('tr.info-attack-fullfront').toggle((ship.attackf != null) || ((effective_stats != null ? effective_stats.attackf : void 0) != null));
            container.find('tr.info-attack-bullseye td.info-data').text(statAndEffectiveStat((ref28 = (ref29 = data.ship_override) != null ? ref29.attackbull : void 0) != null ? ref28 : ship.attackbull, effective_stats, 'attackbull'));
            container.find('tr.info-attack-bullseye').toggle((ship.attackbull != null) || ((effective_stats != null ? effective_stats.attackbull : void 0) != null));
            container.find('tr.info-attack-left td.info-data').text(statAndEffectiveStat((ref30 = (ref31 = data.ship_override) != null ? ref31.attackl : void 0) != null ? ref30 : ship.attackl, effective_stats, 'attackl'));
            container.find('tr.info-attack-left').toggle((ship.attackl != null) || ((effective_stats != null ? effective_stats.attackl : void 0) != null));
            container.find('tr.info-attack-right td.info-data').text(statAndEffectiveStat((ref32 = (ref33 = data.ship_override) != null ? ref33.attackr : void 0) != null ? ref32 : ship.attackr, effective_stats, 'attackr'));
            container.find('tr.info-attack-right').toggle((ship.attackr != null) || ((effective_stats != null ? effective_stats.attackr : void 0) != null));
            container.find('tr.info-attack-back td.info-data').text(statAndEffectiveStat((ref34 = (ref35 = data.ship_override) != null ? ref35.attackb : void 0) != null ? ref34 : ship.attackb, effective_stats, 'attackb'));
            container.find('tr.info-attack-back').toggle((ship.attackb != null) || ((effective_stats != null ? effective_stats.attackb : void 0) != null));
            container.find('tr.info-attack-turret td.info-data').text(statAndEffectiveStat((ref36 = (ref37 = data.ship_override) != null ? ref37.attackt : void 0) != null ? ref36 : ship.attackt, effective_stats, 'attackt'));
            container.find('tr.info-attack-turret').toggle((((ref38 = data.ship_override) != null ? ref38.attackt : void 0) != null) || (ship.attackt != null) || ((effective_stats != null ? effective_stats.attackt : void 0) != null));
            container.find('tr.info-attack-doubleturret td.info-data').text(statAndEffectiveStat((ref39 = (ref40 = data.ship_override) != null ? ref40.attackdt : void 0) != null ? ref39 : ship.attackdt, effective_stats, 'attackdt'));
            container.find('tr.info-attack-doubleturret').toggle((ship.attackdt != null) || ((effective_stats != null ? effective_stats.attackdt : void 0) != null));
            container.find('tr.info-range').hide();
            container.find('td.info-rangebonus').hide();
            container.find('tr.info-agility td.info-data').text(statAndEffectiveStat((ref41 = (ref42 = data.ship_override) != null ? ref42.agility : void 0) != null ? ref41 : ship.agility, effective_stats, 'agility'));
            container.find('tr.info-agility').toggle((((ref43 = data.ship_override) != null ? ref43.agility : void 0) != null) || (ship.agility != null));
            container.find('tr.info-hull td.info-data').text(statAndEffectiveStat((ref44 = (ref45 = data.ship_override) != null ? ref45.hull : void 0) != null ? ref44 : ship.hull, effective_stats, 'hull'));
            container.find('tr.info-hull').toggle((((ref46 = data.ship_override) != null ? ref46.hull : void 0) != null) || (ship.hull != null));
            recurringicon = '';
            if (ship.shieldrecurr != null) {
              count = 0;
              while (count < ship.shieldrecurr) {
                recurringicon += '<sup><i class="fas fa-caret-up"></i></sup>';
                ++count;
              }
            }
            container.find('tr.info-shields td.info-data').html(statAndEffectiveStat((ref47 = (ref48 = data.ship_override) != null ? ref48.shields : void 0) != null ? ref47 : ship.shields, effective_stats, 'shields') + recurringicon);
            container.find('tr.info-shields').toggle((((ref49 = data.ship_override) != null ? ref49.shields : void 0) != null) || (ship.shields != null));
            recurringicon = '';
            if (ship.energyrecurr != null) {
              count = 0;
              while (count < ship.energyrecurr) {
                recurringicon += '<sup><i class="fas fa-caret-up"></i></sup>';
                ++count;
              }
            }
            container.find('tr.info-energy td.info-data').html(statAndEffectiveStat((ref50 = (ref51 = data.ship_override) != null ? ref51.energy : void 0) != null ? ref50 : ship.energy, effective_stats, 'energy') + recurringicon);
            container.find('tr.info-energy').toggle((((ref52 = data.ship_override) != null ? ref52.energy : void 0) != null) || (ship.energy != null));
            if ((((effective_stats != null ? effective_stats.force : void 0) != null) && effective_stats.force > 0) || (data.force != null)) {
              recurringicon = '';
              forcerecurring = 1;
              if ((effective_stats != null ? effective_stats.forcerecurring : void 0) != null) {
                forcerecurring = effective_stats.forcerecurring;
              } else if (data.forcerecurring != null) {
                forcerecurring = data.forcerecurring;
              }
              count = 0;
              while (count < forcerecurring) {
                recurringicon += '<sup><i class="fas fa-caret-up"></i></sup>';
                ++count;
              }
              container.find('tr.info-force td.info-data').html(statAndEffectiveStat((ref53 = (ref54 = data.ship_override) != null ? ref54.force : void 0) != null ? ref53 : data.force, effective_stats, 'force') + recurringicon);
              container.find('tr.info-force').show();
            } else {
              container.find('tr.info-force').hide();
            }
            if (data.charge != null) {
              recurringicon = '';
              if (data.recurring != null) {
                if (data.recurring > 0) {
                  count = 0;
                  while (count < data.recurring) {
                    recurringicon += '<sup><i class="fas fa-caret-up"></i></sup>';
                    ++count;
                  }
                } else {
                  count = data.recurring;
                  while (count < 0) {
                    recurringicon += '<sub><i class="fas fa-caret-down"></i></sub>';
                    ++count;
                  }
                }
              }
              chargeHTML = $.trim(`${data.charge}${recurringicon}`);
              container.find('tr.info-charge td.info-data').html(chargeHTML);
              container.find('tr.info-charge').show();
            } else {
              container.find('tr.info-charge').hide();
            }
            if ((effective_stats != null ? effective_stats.actions : void 0) != null) {
              container.find('tr.info-actions td.info-data').html(this.formatActions((ref55 = (ref56 = data.ship_override) != null ? ref56.actions : void 0) != null ? ref55 : effective_stats.actions, ", "));
            } else {
              container.find('tr.info-actions td.info-data').html(this.formatActions((ref57 = (ref58 = data.ship_override) != null ? ref58.actions : void 0) != null ? ref57 : ship.actions, ", ", (ref59 = data.keyword) != null ? ref59 : []));
            }
            container.find('tr.info-actions').show();
            if (this.isQuickbuild) {
              container.find('tr.info-upgrades').hide();
            } else {
              container.find('tr.info-upgrades').show();
              if (this.isXwa && (data.slotsxwa != null)) {
                container.find('tr.info-upgrades td.info-data').html(data.slotsxwa != null ? ((function() {
                  var len2, m, ref60, results1;
                  ref60 = data.slotsxwa;
                  results1 = [];
                  for (m = 0, len2 = ref60.length; m < len2; m++) {
                    slot = ref60[m];
                    results1.push(exportObj.translate('sloticon', slot));
                  }
                  return results1;
                })()).join(' ') : (data.upgrades != null ? this.listStandardUpgrades(data.upgrades) : 'None'));
              } else {
                container.find('tr.info-upgrades td.info-data').html(data.slots != null ? ((function() {
                  var len2, m, ref60, results1;
                  ref60 = data.slots;
                  results1 = [];
                  for (m = 0, len2 = ref60.length; m < len2; m++) {
                    slot = ref60[m];
                    results1.push(exportObj.translate('sloticon', slot));
                  }
                  return results1;
                })()).join(' ') : (data.upgrades != null ? this.listStandardUpgrades(data.upgrades) : 'None'));
              }
            }
            container.find('p.info-maneuvers').show();
            maneuvers_override = (ref60 = (ref61 = data.ship_override) != null ? ref61.maneuvers : void 0) != null ? ref60 : ship.maneuvers;
            container.find('p.info-maneuvers').html(this.getManeuverTableHTML((ref62 = effective_stats != null ? effective_stats.maneuvers : void 0) != null ? ref62 : maneuvers_override, maneuvers_override));
            break;
          case 'Quickbuild':
            container.find('.info-type').text(this.uitranslation('Quickbuild'));
            container.find('.info-sources').hide(); // there are different sources for the pilot and the upgrade cards, so we won't display any
            container.find('.info-collection').hide(); // same here, hard to give a single number telling a user how often he ownes all required cards
            pilot = exportObj.pilots[data.pilot];
            ship = exportObj.ships[data.ship];
            //logic to determine how many dots to use for uniqueness
            if (pilot.unique != null) {
              uniquedots = "&middot;&nbsp;";
            } else if (pilot.max_per_squad != null) {
              count = 0;
              uniquedots = "";
              while (count < data.max_per_squad) {
                uniquedots = uniquedots.concat("&middot;");
                ++count;
              }
              uniquedots = uniquedots.concat("&nbsp;");
            } else {
              uniquedots = "";
            }
            container.find('.info-name').html(`${uniquedots}${pilot.display_name ? pilot.display_name : pilot.name}${data.suffix != null ? data.suffix : ""}${exportObj.isReleased(pilot) ? "" : ` (${exportObj.translate('ui', 'unreleased')})`}`);
            restriction_info = this.restriction_text(data) + this.upgrade_effect(data);
            if (restriction_info !== '') {
              container.find('p.info-restrictions').html(restriction_info != null ? restriction_info : '');
              container.find('p.info-restrictions').show();
            } else {
              container.find('p.info-restrictions').hide();
            }
            container.find('p.info-text').html((ref63 = pilot.text) != null ? ref63 : '');
            container.find('p.info-text').show();
            container.find('p.info-chassis').html(pilot.chassis != null ? `<strong>${(ref64 = (ref65 = exportObj.chassis[pilot.chassis]) != null ? ref65.display_name : void 0) != null ? ref64 : pilot.chassis}:</strong> ${exportObj.chassis[pilot.chassis].text}` : (ship.chassis != null ? `<strong>${ship.chassis}:</strong> ${exportObj.chassis[ship.chassis].text}` : ""));
            container.find('p.info-chassis').show();
            container.find('tr.info-ship td.info-data').text(data.ship);
            container.find('tr.info-ship').show();
            container.find('tr.info-faction td.info-data').text(exportObj.translate("faction", data.faction));
            container.find('tr.info-faction').hide(); // this information is clear from the context, unless we are in card browser
            if (ship.base != null) {
              container.find('tr.info-base td.info-data').text(exportObj.translate("gameterms", ship.base));
            } else {
              container.find('tr.info-base td.info-data').text(exportObj.translate("gameterms", "Small"));
            }
            container.find('tr.info-base').show();
            container.find('tr.info-skill td.info-data').text(pilot.skill);
            container.find('tr.info-skill').show();
            container.find('tr.info-points').hide();
            container.find('tr.info-loadout').hide();
            container.find('tr.info-engagement td.info-data').text(pilot.skill);
            container.find('tr.info-engagement').show();
            container.find('tr.info-attack td.info-data').text((ref66 = (ref67 = pilot.ship_override) != null ? ref67.attack : void 0) != null ? ref66 : ship.attack);
            container.find('tr.info-attack').toggle(((ref68 = (ref69 = pilot.data.ship_override) != null ? ref69.attack : void 0) != null ? ref68 : ship.attack) > 0);
            container.find('tr.info-attack-fullfront td.info-data').text(ship.attackf);
            container.find('tr.info-attack-fullfront').toggle(ship.attackf != null);
            container.find('tr.info-attack-bullseye td.info-data').text(ship.attackbull);
            container.find('tr.info-attack-bullseye').toggle(ship.attackbull != null);
            container.find('tr.info-attack-left td.info-data').text(ship.attackl);
            container.find('tr.info-attack-left').toggle(ship.attackl != null);
            container.find('tr.info-attack-right td.info-data').text(ship.attackr);
            container.find('tr.info-attack-right').toggle(ship.attackr != null);
            container.find('tr.info-attack-back td.info-data').text(ship.attackb);
            container.find('tr.info-attack-back').toggle(ship.attackb != null);
            container.find('tr.info-attack-turret td.info-data').text(ship.attackt);
            container.find('tr.info-attack-turret').toggle(ship.attackt != null);
            container.find('tr.info-attack-doubleturret td.info-data').text(ship.attackdt);
            container.find('tr.info-attack-doubleturret').toggle(ship.attackdt != null);
            container.find('tr.info-attack td.info-header i.xwing-miniatures-font').addClass((ref70 = ship.attack_icon) != null ? ref70 : 'xwing-miniatures-font-frontarc');
            container.find('tr.info-energy td.info-data').text((ref71 = (ref72 = pilot.ship_override) != null ? ref72.energy : void 0) != null ? ref71 : ship.energy);
            container.find('tr.info-energy').toggle((((ref73 = pilot.ship_override) != null ? ref73.energy : void 0) != null) || (ship.energy != null));
            container.find('tr.info-range').hide();
            container.find('td.info-rangebonus').hide();
            container.find('tr.info-agility td.info-data').text((ref74 = (ref75 = pilot.ship_override) != null ? ref75.agility : void 0) != null ? ref74 : ship.agility);
            container.find('tr.info-agility').show();
            container.find('tr.info-hull td.info-data').text((ref76 = (ref77 = pilot.ship_override) != null ? ref77.hull : void 0) != null ? ref76 : ship.hull);
            container.find('tr.info-hull').show();
            container.find('tr.info-shields td.info-data').text((ref78 = (ref79 = pilot.ship_override) != null ? ref79.shields : void 0) != null ? ref78 : ship.shields);
            container.find('tr.info-shields').show();
            if (((effective_stats != null ? effective_stats.force : void 0) != null) || (data.force != null)) {
              recurringicon = '';
              forcerecurring = 1;
              if ((effective_stats != null ? effective_stats.forcerecurring : void 0) != null) {
                forcerecurring = effective_stats.forcerecurring;
              }
              count = 0;
              while (count < forcerecurring) {
                recurringicon += '<sup><i class="fas fa-caret-up"></i></sup>';
                ++count;
              }
              container.find('tr.info-force td.info-data').html(((ref80 = (ref81 = pilot.ship_override) != null ? ref81.force : void 0) != null ? ref80 : pilot.force) + recurringicon);
              container.find('tr.info-force').show();
            } else {
              container.find('tr.info-force').hide();
            }
            if (data.charge != null) {
              recurringicon = '';
              if (data.recurring != null) {
                if (data.recurring > 0) {
                  count = 0;
                  while (count < data.recurring) {
                    recurringicon += '<sup><i class="fas fa-caret-up"></i></sup>';
                    ++count;
                  }
                } else {
                  count = data.recurring;
                  while (count < 0) {
                    recurringicon += '<sub><i class="fas fa-caret-down"></i></sub>';
                    ++count;
                  }
                }
              }
              chargeHTML = $.trim(`${data.charge}${recurringicon}`);
              container.find('tr.info-charge td.info-data').html(chargeHTML);
              container.find('tr.info-charge').show();
            } else {
              container.find('tr.info-charge').hide();
            }
            container.find('tr.info-actions td.info-data').html(this.formatActions((ref82 = (ref83 = pilot.ship_override) != null ? ref83.actions : void 0) != null ? ref82 : exportObj.ships[data.ship].actions, ", ", (ref84 = pilot.keyword) != null ? ref84 : []));
            container.find('tr.info-actions').show();
            container.find('tr.info-upgrades').show();
            container.find('tr.info-upgrades td.info-data').html(((function() {
              var len2, m, ref85, ref86, results1;
              ref86 = (ref85 = data.upgrades) != null ? ref85 : [];
              results1 = [];
              for (m = 0, len2 = ref86.length; m < len2; m++) {
                upgrade = ref86[m];
                results1.push(exportObj.upgrades[upgrade].display_name != null ? exportObj.upgrades[upgrade].display_name : upgrade);
              }
              return results1;
            })()).join(', ') || 'None');
            container.find('p.info-maneuvers').show();
            container.find('p.info-maneuvers').html(this.getManeuverTableHTML(ship.maneuvers, ship.maneuvers));
            break;
          case 'Addon':
            container.find('.info-type').text(exportObj.translate("slot", additional_opts.addon_type));
            if (data.standard != null) {
              matching_pilots = this.getPilotsMatchingUpgrade(data.name, false);
              container.find('.info-sources.info-data').text(((function() {
                var len2, m, results1;
                results1 = [];
                for (m = 0, len2 = matching_pilots.length; m < len2; m++) {
                  pilot = matching_pilots[m];
                  results1.push(pilot.display_name);
                }
                return results1;
              })()).sort().join(', '));
            } else {
              container.find('.info-sources.info-data').text(((function() {
                var len2, m, ref85, results1;
                ref85 = data.sources;
                results1 = [];
                for (m = 0, len2 = ref85.length; m < len2; m++) {
                  source = ref85[m];
                  results1.push(exportObj.translate('sources', source));
                }
                return results1;
              })()).sort().join(', '));
            }
            container.find('.info-sources').show();
            
            //logic to determine how many dots to use for uniqueness
            if (data.unique != null) {
              uniquedots = "&middot;&nbsp;";
            } else if (data.max_per_squad != null) {
              count = 0;
              uniquedots = "";
              while (count < data.max_per_squad) {
                uniquedots = uniquedots.concat("&middot;");
                ++count;
              }
              uniquedots = uniquedots.concat("&nbsp;");
            } else {
              uniquedots = "";
            }
            if ((((ref85 = this.collection) != null ? ref85.counts : void 0) != null) && (data.standard == null)) {
              addon_count = (ref86 = (ref87 = this.collection.counts) != null ? (ref88 = ref87['upgrade']) != null ? ref88[data.name] : void 0 : void 0) != null ? ref86 : 0;
              container.find('.info-collection').text(this.uitranslation("collectionContentUpgrades", addon_count));
              container.find('.info-collection').show();
            } else {
              container.find('.info-collection').hide();
            }
            container.find('.info-name').html(`${uniquedots}${data.display_name ? data.display_name : data.name}${(exportObj.isReleased(data) || (data.standard != null)) ? "" : ` (${this.uitranslation('unreleased')})`}${data.standard != null ? " (S)" : ""}`);
            if (this.isXwa && (data.pointsxwa != null)) {
              points = data.pointsxwa;
            } else {
              points = data.points;
            }
            if (Array.isArray(points)) {
              point_info = "<i>" + this.uitranslation("varPointCostsPoints", points);
              switch (data.variablepoints) {
                case "Agility":
                  point_info += this.uitranslation("varPointCostsConditionAgility", (function() {
                    var results1 = [];
                    for (var m = 0, ref89 = points.length - 1; 0 <= ref89 ? m <= ref89 : m >= ref89; 0 <= ref89 ? m++ : m--){ results1.push(m); }
                    return results1;
                  }).apply(this));
                  break;
                case "Initiative":
                  point_info += this.uitranslation("varPointCostsConditionIni", (function() {
                    var results1 = [];
                    for (var m = 0, ref90 = points.length - 1; 0 <= ref90 ? m <= ref90 : m >= ref90; 0 <= ref90 ? m++ : m--){ results1.push(m); }
                    return results1;
                  }).apply(this));
                  break;
                case "Base":
                  point_info += this.uitranslation("varPointCostsConditionBase");
                  break;
                case "Faction":
                  point_info += this.uitranslation("varPointCostsConditionFaction", data.faction);
              }
              point_info += "</i>";
            }
            restriction_info = this.restriction_text(data) + this.upgrade_effect(data);
            if ((point_info != null) || (restriction_info !== '')) {
              if ((point_info != null) && (restriction_info !== '')) {
                point_info += "<br/>";
              }
              container.find('p.info-restrictions').html((point_info != null ? point_info : '') + restriction_info);
              container.find('p.info-restrictions').show();
            } else {
              container.find('p.info-restrictions').hide();
            }
            container.find('p.info-text').html((ref91 = data.text) != null ? ref91 : '');
            container.find('p.info-text').show();
            container.find('p.info-chassis').hide();
            container.find('tr.info-ship').hide();
            container.find('tr.info-faction').hide();
            container.find('tr.info-base').hide();
            container.find('tr.info-skill').hide();
            container.find('tr.info-points').hide();
            container.find('tr.info-loadout').hide();
            container.find('tr.info-engagement').hide();
            if (data.energy != null) {
              container.find('tr.info-energy td.info-data').text(data.energy);
              container.find('tr.info-energy').show();
            } else {
              container.find('tr.info-energy').hide();
            }
            if (data.attack != null) {
              container.find('tr.info-attack td.info-data').text(data.attack);
              container.find('tr.info-attack').show();
            } else {
              container.find('tr.info-attack').hide();
            }
            if (data.attackb != null) {
              container.find('tr.info-attack-back td.info-data').text(data.attackb);
              container.find('tr.info-attack-back').show();
            } else {
              container.find('tr.info-attack-back').hide();
            }
            if (data.attackt != null) {
              container.find('tr.info-attack-turret td.info-data').text(data.attackt);
              container.find('tr.info-attack-turret').show();
            } else {
              container.find('tr.info-attack-turret').hide();
            }
            if (data.attackr != null) {
              container.find('tr.info-attack-right td.info-data').text(data.attackr);
              container.find('tr.info-attack-right').show();
            } else {
              container.find('tr.info-attack-right').hide();
            }
            if (data.attackl != null) {
              container.find('tr.info-attack-left td.info-data').text(data.attackl);
              container.find('tr.info-attack-left').show();
            } else {
              container.find('tr.info-attack-left').hide();
            }
            if (data.attackdt != null) {
              container.find('tr.info-attack-doubleturret td.info-data').text(data.attackdt);
              container.find('tr.info-attack-doubleturret').show();
            } else {
              container.find('tr.info-attack-doubleturret').hide();
            }
            if (data.attackbull != null) {
              container.find('tr.info-attack-bullseye td.info-data').text(data.attackbull);
              container.find('tr.info-attack-bullseye').show();
            } else {
              container.find('tr.info-attack-bullseye').hide();
            }
            if (data.attackf != null) {
              container.find('tr.info-attack-fullfront td.info-data').text(data.attackf);
              container.find('tr.info-attack-fullfront').show();
            } else {
              container.find('tr.info-attack-fullfront').hide();
            }
            if (data.charge != null) {
              recurringicon = '';
              if (data.recurring != null) {
                if (data.recurring > 0) {
                  count = 0;
                  while (count < data.recurring) {
                    recurringicon += '<sup><i class="fas fa-caret-up"></i></sup>';
                    ++count;
                  }
                } else {
                  count = data.recurring;
                  while (count < 0) {
                    recurringicon += '<sub><i class="fas fa-caret-down"></i></sub>';
                    ++count;
                  }
                }
              }
              chargeHTML = $.trim(`${data.charge}${recurringicon}`);
              container.find('tr.info-charge td.info-data').html(chargeHTML);
            }
            container.find('tr.info-charge').toggle(data.charge != null);
            if (data.range != null) {
              container.find('tr.info-range td.info-data').text(data.range);
              container.find('tr.info-range').show();
            } else {
              container.find('tr.info-range').hide();
            }
            if (data.rangebonus != null) {
              container.find('td.info-rangebonus').show();
            } else {
              container.find('td.info-rangebonus').hide();
            }
            if (data.force != null) {
              recurringicon = '';
              forcerecurring = 1;
              if (data.forcerecurring != null) {
                forcerecurring = data.forcerecurring;
              }
              count = 0;
              while (count < forcerecurring) {
                recurringicon += '<sup><i class="fas fa-caret-up"></i></sup>';
                ++count;
              }
              container.find('tr.info-force td.info-data').html(data.force + recurringicon);
            }
            container.find('tr.info-force').toggle(data.force != null);
            container.find('tr.info-agility').hide();
            container.find('tr.info-hull').hide();
            container.find('tr.info-shields').hide();
            container.find('tr.info-actions').hide();
            container.find('tr.info-upgrades').hide();
            container.find('p.info-maneuvers').hide();
            break;
          case 'Rules':
            container.find('.info-type').hide();
            container.find('.info-sources').hide();
            container.find('.info-collection').hide();
            container.find('.info-name').html(data.name);
            container.find('.info-name').show();
            container.find('p.info-restrictions').hide();
            container.find('p.info-text').html(data.text);
            container.find('p.info-text').show();
            container.find('tr.info-ship').hide();
            container.find('tr.info-faction').hide();
            container.find('tr.info-base').hide();
            container.find('tr.info-skill').hide();
            container.find('tr.info-points').hide();
            container.find('tr.info-loadout').hide();
            container.find('tr.info-agility').hide();
            container.find('tr.info-hull').hide();
            container.find('tr.info-shields').hide();
            container.find('tr.info-actions').hide();
            container.find('tr.info-upgrades').hide();
            container.find('p.info-maneuvers').hide();
            container.find('tr.info-energy').hide();
            container.find('tr.info-attack').hide();
            container.find('tr.info-attack-turret').hide();
            container.find('tr.info-attack-bullseye').hide();
            container.find('tr.info-attack-fullfront').hide();
            container.find('tr.info-attack-back').hide();
            container.find('tr.info-attack-doubleturret').hide();
            container.find('tr.info-charge').hide();
            container.find('td.info-rangebonus').hide();
            container.find('tr.info-range').hide();
            container.find('tr.info-force').hide();
            break;
          case 'MissingStuff':
            container.find('.info-type').text(this.uitranslation("List of Missing items"));
            container.find('.info-sources').hide();
            container.find('.info-collection').hide();
            container.find('.info-name').html(this.uitranslation("Missing items"));
            container.find('.info-name').show();
            missingStuffInfoText = this.uitranslation("Missing Item List:") + "<ul>";
            for (m = 0, len2 = data.length; m < len2; m++) {
              item = data[m];
              missingStuffInfoText += `<li><strong>${(item.display_name != null ? item.display_name : item.name)}</strong> (`;
              first = true;
              ref92 = item.sources;
              for (o = 0, len3 = ref92.length; o < len3; o++) {
                source = ref92[o];
                if (!first) {
                  missingStuffInfoText += ", ";
                }
                missingStuffInfoText += source;
                first = false;
              }
              missingStuffInfoText += ")</li>";
            }
            missingStuffInfoText += "</ul>";
            container.find('p.info-restrictions').hide();
            container.find('p.info-text').html(missingStuffInfoText);
            container.find('p.info-text').show();
            container.find('tr.info-ship').hide();
            container.find('tr.info-faction').hide();
            container.find('tr.info-base').hide();
            container.find('tr.info-skill').hide();
            container.find('tr.info-points').hide();
            container.find('tr.info-loadout').hide();
            container.find('tr.info-agility').hide();
            container.find('tr.info-hull').hide();
            container.find('tr.info-shields').hide();
            container.find('tr.info-actions').hide();
            container.find('tr.info-upgrades').hide();
            container.find('p.info-maneuvers').hide();
            container.find('tr.info-energy').hide();
            container.find('tr.info-attack').hide();
            container.find('tr.info-attack-turret').hide();
            container.find('tr.info-attack-bullseye').hide();
            container.find('tr.info-attack-fullfront').hide();
            container.find('tr.info-attack-back').hide();
            container.find('tr.info-attack-doubleturret').hide();
            container.find('tr.info-charge').hide();
            container.find('td.info-rangebonus').hide();
            container.find('tr.info-range').hide();
            container.find('tr.info-force').hide();
            break;
          case 'Damage':
            container.find('.info-type').text(exportObj.translate("types", data.type));
            container.find('.info-sources.info-data').text(((function() {
              var len4, q, ref93, results1;
              ref93 = data.sources;
              results1 = [];
              for (q = 0, len4 = ref93.length; q < len4; q++) {
                source = ref93[q];
                results1.push(exportObj.translate('sources', source));
              }
              return results1;
            })()).sort().join(', '));
            container.find('.info-sources').show();
            if (((ref93 = this.collection) != null ? ref93.counts : void 0) != null) {
              addon_count = (ref94 = (ref95 = this.collection.counts) != null ? (ref96 = ref95['damage']) != null ? ref96[data.name] : void 0 : void 0) != null ? ref94 : 0;
              container.find('.info-collection').text(this.uitranslation("collectionContentUpgrades", addon_count));
              container.find('.info-collection').show();
            } else {
              container.find('.info-collection').hide();
            }
            container.find('.info-name').html(`${data.display_name ? data.display_name : data.name} (${data.quantity}x)`);
            container.find('p.info-restrictions').hide();
            container.find('p.info-text').html((ref97 = data.text) != null ? ref97 : '');
            container.find('p.info-text').show();
            container.find('p.info-chassis').hide();
            container.find('tr.info-ship').hide();
            container.find('tr.info-faction').hide();
            container.find('tr.info-base').hide();
            container.find('tr.info-skill').hide();
            container.find('tr.info-points').hide();
            container.find('tr.info-loadout').hide();
            container.find('tr.info-engagement').hide();
            container.find('tr.info-energy').hide();
            container.find('tr.info-attack').hide();
            container.find('tr.info-attack-back').hide();
            container.find('tr.info-attack-turret').hide();
            container.find('tr.info-attack-right').hide();
            container.find('tr.info-attack-left').hide();
            container.find('tr.info-attack-doubleturret').hide();
            container.find('tr.info-attack-bullseye').hide();
            container.find('tr.info-attack-fullfront').hide();
            container.find('tr.info-charge').hide();
            container.find('tr.info-range').hide();
            container.find('td.info-rangebonus').hide();
            container.find('tr.info-force').hide();
            container.find('tr.info-agility').hide();
            container.find('tr.info-hull').hide();
            container.find('tr.info-shields').hide();
            container.find('tr.info-actions').hide();
            container.find('tr.info-upgrades').hide();
            container.find('p.info-maneuvers').hide();
        }
        if (container !== this.mobile_tooltip_modal) {
          container.find('.info-well').show();
          container.find('.intro').hide();
        }
        this.tooltip_currently_displaying = data;
        // fix card viewer to view, if it is fully visible (it might not be e.g. on mobile devices. In that case keep it on its static position, so you can scroll to see it)
        if ($(window).width() >= 768) {
          well = container.find('.info-well');
          if ($.isElementInView(well, true)) {
            return well.css('position', 'fixed');
          } else {
            return well.css('position', 'static');
          }
        }
      }
    }

    async _randomizerLoopBody(data) {
      var addon, available_pilots, available_ships, available_upgrades, expensive_slots, j, l, len, len1, len2, len3, len4, m, new_ship, o, pilot, q, ref, ref1, ref2, ref3, ref4, ship, ship_type, sorted, unused_addons, upgrade;
      if (data.keep_running) {
        if (this.total_points === data.max_points) {
          // ToDo: Check if we meet the requirement of minimum 3 ships?
          // Ships are done, now start equipping upgrades to them!
          data.keep_running = false;
          if (this.isQuickbuild) {
            data.keep_running = false;
            return;
          }
          ref = this.ships;
          for (j = 0, len = ref.length; j < len; j++) {
            ship = ref[j];
            expensive_slots = [];
            if ((ship.pilot.loadout != null) && (ship.pilot.upgrades == null)) {
              while (ship.upgrade_points_total < ship.pilot.loadout) {
                // we wan't to utilize newly added upgrade slots, so we will check for slots iteratively
                unused_addons = [];
                ref1 = ship.upgrades;
                for (l = 0, len1 = ref1.length; l < len1; l++) {
                  upgrade = ref1[l];
                  if (!((upgrade.data != null) || ((upgrade.occupied_by != null) && upgrade.occupied_by !== null) || indexOf.call(expensive_slots, upgrade) >= 0)) {
                    unused_addons.push(upgrade);
                  }
                }
                if (unused_addons.length === 0) {
                  break; // it's fine to not spend all points - otherwise few-slot ships will always receive the same upgrade(s)
                }
                // select random slot
                addon = unused_addons[$.randomInt(unused_addons.length)];
                // select and equip random upgrade
                available_upgrades = (function() {
                  var len2, m, ref2, results1;
                  ref2 = this.getAvailableUpgradesIncluding(addon.slot, null, ship, addon, '', this.dfl_filter_func, sorted = false);
                  results1 = [];
                  for (m = 0, len2 = ref2.length; m < len2; m++) {
                    upgrade = ref2[m];
                    if ((exportObj.upgradesById[upgrade.id].sources.intersects(data.allowed_sources) && ((!data.collection_only) || this.collection.checkShelf('upgrade', upgrade.name))) && !upgrade.disabled) {
                      results1.push(upgrade);
                    }
                  }
                  return results1;
                }).call(this);
                if (available_upgrades.length > 0) {
                  upgrade = available_upgrades[$.randomInt(available_upgrades.length)];
                  await addon.setById(upgrade.id);
                } else {
                  // that slot has only expensive stuff. ignore it in the future!
                  expensive_slots.push(addon);
                }
              }
            }
          }
        } else if (this.total_points < data.max_points) {
          // need to add more ships
          // Add random ship
          // try to find a ship that is cheap enough. If none exist, pick an expensive one and remove a random ship in the next iteration
          available_ships = this.getAvailableShipsMatchingAndCheapEnough(data.max_points - this.total_points, '', false, data.collection_only);
          if (available_ships.length === 0) {
            available_ships = this.getAvailableShipsMatching('', false, data.collection_only);
          }
          if ((available_ships.length > 0) && ((this.ships.length < data.ship_limit) || (data.ship_limit === 0))) {
            ship_type = available_ships[$.randomInt(available_ships.length)].name;
            available_pilots = this.getAvailablePilotsForShipIncluding(ship_type);
            if (available_pilots.length === 0) {
              return;
            }
            
            // edge case: It might have been a ship selected, that has only unique pilots - which all have been already selected 
            pilot = available_pilots[$.randomInt(available_pilots.length)];
            if (!pilot.disabled && (this.isQuickbuild ? exportObj.pilots[exportObj.quickbuildsById[pilot.id].pilot] : exportObj.pilotsById[pilot.id]).sources.intersects(data.allowed_sources) && ((!data.collection_only) || this.collection.checkShelf('pilot', (this.isQuickbuild ? exportObj.quickbuildsById[pilot.id] : pilot.name)))) {
              new_ship = this.addShip();
              new_ship.setPilotById(pilot.id);
            }
          }
        } else {
          // need to remove a ship, cause we are too expensive
          this.removeShip(this.ships[$.randomInt(this.ships.length)]);
        }
        // continue the "loop"
        return window.setTimeout(this._makeRandomizerLoopFunc(data), 0);
      } else {
        //console.log "Clearing timer #{data.timer}, iterations=#{data.iterations}, keep_running=#{data.keep_running}"
        // we have to stop randomizing, but should do a final check on our point costs. (in case our last step was adding something expensive)
        while (this.total_points > data.max_points) {
          this.removeShip(this.ships[$.randomInt(this.ships.length)]);
        }
        if (data.fill_zero_pts) {
          ref2 = this.ships;
          for (m = 0, len2 = ref2.length; m < len2; m++) {
            ship = ref2[m];
            ref3 = ship.upgrades;
            for (o = 0, len3 = ref3.length; o < len3; o++) {
              addon = ref3[o];
              if (!!((addon.data != null) || ((addon.occupied_by != null) && addon.occupied_by !== null))) {
                continue;
              }
              available_upgrades = (function() {
                var len4, q, ref4, results1;
                ref4 = this.getAvailableUpgradesIncluding(addon.slot, null, addon.ship, addon, '', this.dfl_filter_func, sorted = false);
                results1 = [];
                for (q = 0, len4 = ref4.length; q < len4; q++) {
                  upgrade = ref4[q];
                  if (exportObj.upgradesById[upgrade.id].sources.intersects(data.allowed_sources) && (upgrade.points < 1) && ((!data.collection_only) || this.collection.checkShelf('upgrade', upgrade.name))) {
                    results1.push(upgrade);
                  }
                }
                return results1;
              }).call(this);
              upgrade = available_upgrades.length > 0 ? available_upgrades[$.randomInt(available_upgrades.length)] : void 0;
              if (upgrade && !upgrade.disabled) {
                addon.setById(upgrade.id);
              }
            }
          }
        }
        window.clearTimeout(data.timer);
        ref4 = this.ships;
        // Update all selectors
        for (q = 0, len4 = ref4.length; q < len4; q++) {
          ship = ref4[q];
          ship.updateSelections();
        }
        this.suppress_automatic_new_ship = false;
        return this.addShip();
      }
    }

    _makeRandomizerLoopFunc(data) {
      return () => {
        return this._randomizerLoopBody(data);
      };
    }

    randomSquad(max_points = 200, allowed_sources = null, timeout_ms = 1000, ship_limit = 0, collection_only = true, fill_zero_pts = false) {
      var data, stopHandler;
      this.backend_status.fadeOut('slow');
      this.suppress_automatic_new_ship = true;
      if (allowed_sources.length < 1) {
        allowed_sources = null;
      }
      
        // Clear all existing ships
      while (this.ships.length > 0) {
        this.removeShip(this.ships[0]);
      }
      if (this.ships.length > 0) {
        throw new Error("Ships not emptied");
      }
      data = {
        max_points: max_points,
        ship_limit: ship_limit,
        keep_running: true,
        allowed_sources: allowed_sources != null ? allowed_sources : exportObj.expansions,
        collection_only: (this.collection != null) && (this.collection.checks.collectioncheck === "true") && collection_only,
        fill_zero_pts: fill_zero_pts
      };
      stopHandler = () => {
        //console.log "*** TIMEOUT *** TIMEOUT *** TIMEOUT ***"
        return data.keep_running = false;
      };
      data.timer = window.setTimeout(stopHandler, timeout_ms);
      //console.log "Timer set for #{timeout_ms}ms, timer is #{data.timer}"
      window.setTimeout(this._makeRandomizerLoopFunc(data), 0);
      this.resetCurrentSquad();
      this.current_squad.name = this.uitranslation('Random Squad');
      return this.container.trigger('xwing-backend:squadNameChanged');
    }

    setBackend(backend) {
      var j, len, meth, ref, results1;
      this.backend = backend;
      if (this.waiting_for_backend != null) {
        ref = this.waiting_for_backend;
        results1 = [];
        for (j = 0, len = ref.length; j < len; j++) {
          meth = ref[j];
          results1.push(meth());
        }
        return results1;
      }
    }

    upgrade_effect(card) {
      var addonname, comma, data, j, l, len, len1, ref, ref1, removestext, slot, statchange, text;
      removestext = text = comma = '';
      if (card.modifier_func) {
        statchange = {
          attack: 0,
          attackf: 0,
          attackbull: 0,
          attackb: 0,
          attackt: 0,
          attackl: 0,
          attackr: 0,
          attackdt: 0,
          energy: 0,
          agility: 0,
          hull: 0,
          shields: 0,
          force: 0,
          actions: [],
          maneuvers: [0, 0]
        };
        card.modifier_func(statchange);
        if (statchange.attack !== 0) {
          text += comma + `%FRONTARC% (${statchange.attack})`;
          comma = ', ';
        }
        if (statchange.attackf !== 0) {
          text += comma + `%FULLFRONTARC% (${statchange.attackf})`;
          comma = ', ';
        }
        if (statchange.attackbull !== 0) {
          text += comma + `%BULLSEYEARC% (${statchange.attackbull})`;
          comma = ', ';
        }
        if (statchange.attackb !== 0) {
          text += comma + `%REARARC% (${statchange.attackb})`;
          comma = ', ';
        }
        if (statchange.attackt !== 0) {
          text += comma + `%SINGLETURRETARC% (${statchange.attackt})`;
          comma = ', ';
        }
        if (statchange.attackl !== 0) {
          text += comma + `%LEFTARC% (${statchange.attackl})`;
          comma = ', ';
        }
        if (statchange.attackr !== 0) {
          text += comma + `%RIGHTARC% (${statchange.attackr})`;
          comma = ', ';
        }
        if (statchange.attackdt !== 0) {
          text += comma + `%DOUBLETURRETARC% (${statchange.attackdt})`;
          comma = ', ';
        }
        if (statchange.energy !== 0) {
          text += comma + `%ENERGY% (${statchange.energy})`;
          comma = ', ';
        }
        if (statchange.agility !== 0) {
          text += comma + `%AGILITY% (${statchange.agility})`;
          comma = ', ';
        }
        if (statchange.hull !== 0) {
          text += comma + `%HULL% (${statchange.hull})`;
          comma = ', ';
        }
        if (statchange.shields !== 0) {
          text += comma + `%SHIELD% (${statchange.shields})`;
          comma = ', ';
        }
        if (statchange.actions.length > 0) {
          text += comma + this.formatActions(statchange.actions, ", ");
          comma = ', ';
        }
      }
      if (card.confersAddons) {
        ref = card.confersAddons;
        for (j = 0, len = ref.length; j < len; j++) {
          addonname = ref[j];
          if (addonname.slot === "Force") {
            text += comma + "%FORCEPOWER%";
          } else {
            text += comma + `%${addonname.slot.toUpperCase().replace(/[^a-z0-9]/gi, '')}%`;
          }
          comma = ', ';
        }
      }
      if (card.unequips_upgrades) {
        comma = '';
        ref1 = card.unequips_upgrades;
        for (l = 0, len1 = ref1.length; l < len1; l++) {
          slot = ref1[l];
          removestext += comma + `%${slot.toUpperCase().replace(/[^a-z0-9]/gi, '')}%`;
          comma = ', ';
        }
      }
      if (text !== '') {
        data = {
          text: `</br><b>${this.uitranslation("adds", text)}</b>`
        };
        if (removestext !== '') {
          data.text += `</br><b>${this.uitranslation("removes", removestext)}</b>`;
        }
        return exportObj.fixIcons(data);
      } else {
        return '';
      }
    }

    restriction_text(card) {
      var array, b, card_restrictions, comma, data, factionitem, ignoreShip, index, j, l, len, len1, len2, len3, m, o, othertext, r, ref, ref1, shipname, standardized, text, uniquetext;
      uniquetext = comma = othertext = text = '';
      ignoreShip = false;
      standardized = card.standardized != null;
      if (this.isXwa && (card.standardizedxwa != null)) {
        standardized = card.standardizedxwa;
      }
      if (card.restrictions != null) {
        card_restrictions = card.restrictions;
      }
      if (this.isXwa && (card.restrictionsxwa != null)) {
        card_restrictions = card.restrictionsxwa;
      }
      if (card_restrictions != null) {
        for (j = 0, len = card_restrictions.length; j < len; j++) {
          r = card_restrictions[j];
          switch (r[0]) {
            case "FactionOrUnique":
              othertext += comma + exportObj.translate('faction', `${r[2]}`);
              uniquetext = exportObj.translate('restrictions', " or Squad Including") + ` ${r[1]}`;
              break;
            case "Base":
              for (index = l = 0, len1 = r.length; l < len1; index = ++l) {
                b = r[index];
                if (b === "Base") {
                  text += comma;
                  continue;
                }
                text += `${b} `;
                if (index < r.length - 1) {
                  text += "or ";
                } else {
                  text += exportObj.translate('restrictions', "Ship");
                }
              }
              break;
            case "Action":
              array = [r[1]];
              text += comma + this.formatActions(array, "", []);
              break;
            case "Equipped":
              text += comma + `%${r[1].toUpperCase().replace(/[^a-z0-9]/gi, '')}% Equipped`;
              break;
            case "Slot":
              text += comma + exportObj.translate('restrictions', "Extra") + ` %${r[1].toUpperCase().replace(/[^a-z0-9]/gi, '')}%`;
              break;
            case "Keyword":
              text += comma + exportObj.translate('restrictions', `${r[1]}`);
              ignoreShip = true;
              break;
            case "AttackArc":
              text += comma + "%REARARC%";
              break;
            case "ShieldsGreaterThan":
              text += comma + `%SHIELD% > ${r[1]}`;
              break;
            case "EnergyGreatterThan":
              text += comma + `%ENERGY% > ${r[1]}`;
              break;
            case "InitiativeGreaterThan":
              text += comma + exportObj.translate('restrictions', "Initiative") + ` > ${r[1]}`;
              break;
            case "InitiativeLessThan":
              text += comma + exportObj.translate('restrictions', "Initiative") + ` < ${r[1]}`;
              break;
            case "HasForce":
              text += comma + (r[1] ? "" : "No ") + "%FORCE%";
              break;
            case "AgilityEquals":
              text += comma + exportObj.translate('restrictions', "Agility") + ` = ${r[1]}`;
              break;
            case "isUnique":
              if (r[1] === true) {
                text += comma + exportObj.translate('restrictions', "Limited");
              } else {
                text += comma + exportObj.translate('restrictions', "Non-Limited");
              }
              break;
            case "Format":
              text += comma + exportObj.translate('restrictions', `${r[1]} Ship`);
              break;
            case "Faction":
              othertext += comma + exportObj.translate('faction', `${r[1]}`);
          }
          comma = ', ';
        }
      }
      if (!card.skill) {
        if (othertext === '') {
          if (card.faction) {
            if (card.faction instanceof Array) {
              ref = card.faction;
              for (m = 0, len2 = ref.length; m < len2; m++) {
                factionitem = ref[m];
                othertext += comma + exportObj.translate('faction', `${factionitem}`);
                comma = ' or ';
              }
            } else {
              othertext += comma + exportObj.translate('faction', `${card.faction}`);
            }
            comma = ', ';
          }
        }
        if (card.ship && ignoreShip === false) {
          if (card.ship instanceof Array) {
            ref1 = card.ship;
            for (o = 0, len3 = ref1.length; o < len3; o++) {
              shipname = ref1[o];
              othertext += comma + shipname;
              comma = ' or ';
            }
          } else {
            othertext += comma + card.ship;
          }
          comma = ', ';
        }
        if (card.solitary) {
          othertext += comma + exportObj.translate('gameterms', "Solitary");
          comma = ', ';
        }
        if (standardized) {
          othertext += comma + exportObj.translate('gameterms', "Standardized");
          comma = ', ';
        }
      }
      text += othertext + uniquetext;
      if (text !== '') {
        data = {
          text: "<i><b>" + exportObj.translate('restrictions', "Restrictions") + ":</b> " + text + "</i>"
        };
        return exportObj.fixIcons(data);
      } else {
        return '';
      }
    }

    describeSquad() {
      var ship;
      if (this.getNotes().trim() === '') {
        return ((function() {
          var j, len, ref, results1;
          ref = this.ships;
          results1 = [];
          for (j = 0, len = ref.length; j < len; j++) {
            ship = ref[j];
            if (ship.pilot != null) {
              results1.push(ship.pilot.name);
            }
          }
          return results1;
        }).call(this)).join(', ');
      } else {
        return this.getNotes();
      }
    }

    listCards() {
      var card_obj, j, l, len, len1, ref, ref1, ship, upgrade;
      card_obj = {};
      ref = this.ships;
      for (j = 0, len = ref.length; j < len; j++) {
        ship = ref[j];
        if (ship.pilot != null) {
          card_obj[ship.pilot.name] = null;
          ref1 = ship.upgrades;
          for (l = 0, len1 = ref1.length; l < len1; l++) {
            upgrade = ref1[l];
            if (upgrade.data != null) {
              card_obj[upgrade.data.name] = null;
            }
          }
        }
      }
      return Object.keys(card_obj).sort();
    }

    getNotes() {
      return this.notes.val();
    }

    getTag() {
      return this.tag.val();
    }

    getObstacles() {
      return this.current_obstacles;
    }

    isSquadPossibleWithCollection() {
      var j, l, len, len1, missingStuff, pilot_is_available, ref, ref1, ref2, ref3, ref4, ship, ship_is_available, upgrade, upgrade_is_available, validity;
      // If the collection is uninitialized or empty, don't actually check it.
      if (Object.keys((ref = (ref1 = this.collection) != null ? ref1.expansions : void 0) != null ? ref : {}).length === 0) {
        // console.log "collection not ready or is empty"
        return [true, []];
      } else if (((ref2 = this.collection) != null ? ref2.checks.collectioncheck : void 0) !== "true") {
        // console.log "collection check not enabled"
        return [true, []];
      }
      this.collection.reset();
      validity = true;
      missingStuff = [];
      ref3 = this.ships;
      for (j = 0, len = ref3.length; j < len; j++) {
        ship = ref3[j];
        if (ship.pilot != null) {
          // Try to get both the physical model and the pilot card.
          ship_is_available = this.collection.use('ship', ship.pilot.ship);
          pilot_is_available = this.collection.use('pilot', ship.pilot.name);
          if (!(ship_is_available && pilot_is_available)) {
            // console.log "#{@faction}: Ship #{ship.pilot.ship} available: #{ship_is_available}"
            // console.log "#{@faction}: Pilot #{ship.pilot.name} available: #{pilot_is_available}"
            validity = false;
          }
          if (!ship_is_available) {
            missingStuff.push(ship.data);
          }
          if (!pilot_is_available) {
            missingStuff.push(ship.pilot);
          }
          if (ship.pilot.upgrades == null) {
            ref4 = ship.upgrades;
            for (l = 0, len1 = ref4.length; l < len1; l++) {
              upgrade = ref4[l];
              if (upgrade.data != null) {
                upgrade_is_available = this.collection.use('upgrade', upgrade.data.name);
                if (!(upgrade_is_available || (upgrade.data.standard != null))) {
                  // console.log "#{@faction}: Upgrade #{upgrade.data.name} available: #{upgrade_is_available}"
                  validity = false;
                }
                if (!(upgrade_is_available || (upgrade.data.standard != null))) {
                  missingStuff.push(upgrade.data);
                }
              }
            }
          }
        }
      }
      return [validity, missingStuff];
    }

    checkCollection() {
      var missingStuff, squadPossible;
      // console.log "#{@faction}: Checking validity of squad against collection..."
      if (this.collection != null) {
        [squadPossible, missingStuff] = this.isSquadPossibleWithCollection();
        this.collection_invalid_container.toggleClass('d-none', squadPossible);
        return this.collection_invalid_container.on('mouseover', (e) => {
          return this.showTooltip('MissingStuff', missingStuff);
        });
      }
    }

    toXWS() {
      var _, candidate, j, l, last_id, len, len1, len2, len3, m, match, matches, multisection_id_to_pilots, name1, o, obstacles, pilot, q, ref, ref1, ref2, ref3, rules, ship, unmatched, unmatched_pilot, versioninfo, xws;
      // Often you will want JSON.stringify(builder.toXWS())
      versioninfo = "09/06/2024";
      rules = "AMG";
      if (this.isXwa) {
        versioninfo = "R1";
        rules = "XWA";
      }
      xws = {
        description: this.getNotes(),
        faction: exportObj.toXWSFaction[this.faction],
        name: this.current_squad.name,
        pilots: [],
        points: this.total_points,
        vendor: {
          yasb: {
            builder: 'YASB - X-Wing 2.5',
            builder_url: window.location.href.split('?')[0],
            link: this.getPermaLink()
          }
        },
        version: versioninfo,
        ruleset: rules
      };
      ref = this.ships;
      // there is no point to have this version identifier, if we never actually increase it, right?
      for (j = 0, len = ref.length; j < len; j++) {
        ship = ref[j];
        if (ship.pilot != null) {
          xws.pilots.push(ship.toXWS());
        }
      }
      // Associate multisection ships
      // This maps id to list of pilots it comprises
      multisection_id_to_pilots = {};
      last_id = 0;
      unmatched = (function() {
        var l, len1, ref1, results1;
        ref1 = xws.pilots;
        results1 = [];
        for (l = 0, len1 = ref1.length; l < len1; l++) {
          pilot = ref1[l];
          if (pilot.multisection != null) {
            results1.push(pilot);
          }
        }
        return results1;
      })();
      for (_ = l = 0, ref1 = unmatched.length ** 2; (0 <= ref1 ? l < ref1 : l > ref1); _ = 0 <= ref1 ? ++l : --l) {
        if (unmatched.length === 0) {
          break;
        }
        // console.log "Top of loop, unmatched: #{m.name for m in unmatched}"
        unmatched_pilot = unmatched.shift();
        if (unmatched_pilot.multisection_id == null) {
          unmatched_pilot.multisection_id = last_id++;
        }
        if (multisection_id_to_pilots[name1 = unmatched_pilot.multisection_id] == null) {
          multisection_id_to_pilots[name1] = [unmatched_pilot];
        }
        if (unmatched.length === 0) {
          break;
        }
        // console.log "Finding matches for #{unmatched_pilot.name} (assigned id=#{unmatched_pilot.multisection_id})"
        matches = [];
        for (m = 0, len1 = unmatched.length; m < len1; m++) {
          candidate = unmatched[m];
          // console.log "-> examine #{candidate.name}"
          if (ref2 = unmatched_pilot.name, indexOf.call(candidate.multisection, ref2) >= 0) {
            matches.push(candidate);
            unmatched_pilot.multisection.removeItem(candidate.name);
            candidate.multisection.removeItem(unmatched_pilot.name);
            candidate.multisection_id = unmatched_pilot.multisection_id;
            // console.log "-> MATCH FOUND #{candidate.name}, assigned id=#{candidate.multisection_id}"
            multisection_id_to_pilots[candidate.multisection_id].push(candidate);
            if (unmatched_pilot.multisection.length === 0) {
              // console.log "-> No more sections to match for #{unmatched_pilot.name}"
              break;
            }
          }
        }
        for (o = 0, len2 = matches.length; o < len2; o++) {
          match = matches[o];
          if (match.multisection.length === 0) {
            // console.log "Dequeue #{match.name} since it has no more sections to match"
            unmatched.removeItem(match);
          }
        }
      }
      ref3 = xws.pilots;
      for (q = 0, len3 = ref3.length; q < len3; q++) {
        pilot = ref3[q];
        if (pilot.multisection != null) {
          delete pilot.multisection;
        }
      }
      obstacles = this.getObstacles();
      if ((obstacles != null) && obstacles.length > 0) {
        xws.obstacles = obstacles;
      }
      return xws;
    }

    toMinimalXWS() {
      var k, ref, v, xws;
      // Just what's necessary
      xws = this.toXWS();
      for (k in xws) {
        if (!hasProp.call(xws, k)) continue;
        v = xws[k];
        if (k !== 'faction' && k !== 'pilots' && k !== 'version') {
          delete xws[k];
        }
      }
      ref = xws.pilots;
      for (k in ref) {
        if (!hasProp.call(ref, k)) continue;
        v = ref[k];
        if (k !== 'id' && k !== 'upgrades' && k !== 'multisection_id') {
          delete xws[k];
        }
      }
      return xws;
    }

    loadFromXWS(xws, cb) {
      var addons, afterLoad, base1, error, gamemode, j, key, l, len, len1, len2, m, new_ship, pilot, pilotxws, possible_pilot, possible_pilots, ref, ref1, ref2, ref3, ref4, serialized_squad, serialized_squad_intro, slot, success, upgrade, upgrade_canonical, upgrade_canonicals, upgrade_type, version_list, x, xws_faction;
      success = null;
      error = null;
      if (xws.version != null) {
        version_list = (function() {
          var j, len, ref, results1;
          ref = xws.version.split('.');
          results1 = [];
          for (j = 0, len = ref.length; j < len; j++) {
            x = ref[j];
            results1.push(parseInt(x));
          }
          return results1;
        })();
      } else {
        version_list = [
          0,
          2 // Version tag is optional, so let's just assume it is some 2.0 xws if no version is given
        ];
      }
      switch (false) {
        // Not doing backward compatibility pre-1.x
        case !(version_list > [0, 1] || xws.ruleset === 'XWA'):
          xws_faction = exportObj.fromXWSFaction[xws.faction];
          if (this.faction !== xws_faction) {
            throw new Error(`Attempted to load XWS for ${xws.faction} but builder is ${this.faction}`);
          }
          if (xws.name != null) {
            this.current_squad.name = xws.name;
          }
          if (xws.description != null) {
            this.notes.val(xws.description);
          }
          if (xws.obstacles != null) {
            this.current_squad.additional_data.obstacles = xws.obstacles;
          }
          this.suppress_automatic_new_ship = true;
          this.removeAllShips();
          success = true;
          error = "";
          // we use our current gamemode as default, but switch to standard if we are in XWA but the loaded xws specifies AMG or vice versa
          if (this.isStandard) {
            gamemode = 'h';
          } else if (this.isEpic) {
            gamemode = 'e';
          } else if (this.isXwa) {
            gamemode = 'b';
          } else {
            gamemode = 's';
          }
          if ((xws.ruleset != null) && xws.ruleset === 'XWA') {
            gamemode = 'b';
          } else if ((xws.ruleset != null) && xws.ruleset === 'AMG' && gamemode === 'b') {
            gamemode = 'h';
          }
          serialized_squad = "";
          ref = xws.pilots;
          for (j = 0, len = ref.length; j < len; j++) {
            pilot = ref[j];
            new_ship = this.addShip();
            // we add some backward compatibility here, to allow imports from Launch Bay Next Squad Builder
            // According to xws-spec, for 2nd edition we use id instead of name
            // however, we will accept a name instead of an id as well.
            if (pilot.id) {
              pilotxws = pilot.id;
            } else if (pilot.name) {
              pilotxws = pilot.name;
            } else {
              success = false;
              error = "Pilot without identifier";
              break;
            }
            // add pilot id
            if (exportObj.pilotsByFactionXWS[xws_faction][pilotxws] != null) {
              serialized_squad += exportObj.pilotsByFactionXWS[xws_faction][pilotxws][0].id;
            } else if (exportObj.pilotsByUniqueName[pilotxws] && exportObj.pilotsByUniqueName[pilotxws].length === 1) {
              serialized_squad += exportObj.pilotsByUniqueName[pilotxws][0].id;
            } else {
              ref1 = exportObj.pilotsByUniqueName;
              for (key in ref1) {
                possible_pilots = ref1[key];
                for (l = 0, len1 = possible_pilots.length; l < len1; l++) {
                  possible_pilot = possible_pilots[l];
                  if ((possible_pilot.xws && possible_pilot.xws === pilotxws) || (!possible_pilot.xws && key === pilotxws)) {
                    serialized_squad += possible_pilot.id;
                    break;
                  }
                }
              }
            }
            // game mode version check: pilot and ship
            if (!exportObj.standardCheck(pilot, true) && gamemode === 'h') {
              gamemode = 's';
            }
            serialized_squad += "X";
            // add upgrade ids
            // Turn all the upgrades into a flat list so we can keep trying to add them
            addons = [];
            ref3 = (ref2 = pilot.upgrades) != null ? ref2 : {};
            for (upgrade_type in ref3) {
              upgrade_canonicals = ref3[upgrade_type];
              for (m = 0, len2 = upgrade_canonicals.length; m < len2; m++) {
                upgrade_canonical = upgrade_canonicals[m];
                // console.log upgrade_type, upgrade_canonical
                slot = null;
                slot = (ref4 = exportObj.fromXWSUpgrade[upgrade_type]) != null ? ref4 : upgrade_type.capitalize();
                if (upgrade_canonical != null) {
                  upgrade = (base1 = exportObj.upgradesBySlotXWSName[slot])[upgrade_canonical] != null ? base1[upgrade_canonical] : base1[upgrade_canonical] = exportObj.upgradesBySlotCanonicalName[slot][upgrade_canonical];
                  if (upgrade == null) {
                    console.log("Failed to load xws upgrade: " + upgrade_canonical);
                    error += "Skipped upgrade " + upgrade_canonical;
                    success = false;
                    continue;
                  }
                  serialized_squad += upgrade.id;
                  serialized_squad += "W";
                  if (!exportObj.standardCheck(upgrade, true) && gamemode === 'h') {
                    gamemode = 's';
                  }
                }
              }
            }
            serialized_squad += "XY";
          }
          serialized_squad_intro = "v9Z" + gamemode + "Z20Z"; // serialization v9, extended squad, 20 points
          // serialization schema SHIPID:UPGRADEID,UPGRADEID,...,UPGRADEID:;SHIPID:UPGRADEID,...
          serialized_squad = serialized_squad_intro + serialized_squad;
          afterLoad = () => {
            this.current_squad.dirty = true;
            this.container.trigger('xwing-backend:squadNameChanged');
            this.container.trigger('xwing-backend:squadDirtinessChanged');
            return cb({
              success: success,
              error: error
            });
          };
          this.loadFromSerialized(serialized_squad, afterLoad);
          break;
        default:
          success = false;
          error = "Unsupported XWS version";
          cb(success, error);
      }
      return cb({
        success: success,
        error: error
      });
    }

  };

  dfl_filter_func = function() {
    return true;
  };

  return SquadBuilder;

}).call(this);

Ship = class Ship {
  constructor(args) {
    // args
    this.builder = args.builder;
    this.container = args.container;
    // internal state
    this.pilot = null;
    this.data = null; // ship data
    this.quickbuildId = -1;
    this.linkedShip = null; // some quickbuilds contain two ships, this variable may reference a Ship beeing part of the same quickbuild card
    this.primary = true; // only the primary ship of a linked ship pair will contribute points and serialization id
    this.upgrades = [];
    this.upgrade_points_total = 0;
    this.wingmates = []; // stores wingmates (quickbuild stuff only) 
    this.destroystate = 0;
    this.uitranslation = this.builder.uitranslation;
    this.usesxwaSlots = false; // flag if we use xwa slots. This is needed, if we switch betwen XWA/AMG points to rebuild the pilot if the slots change
    this.setupUI();
  }

  async destroy(cb) {
    var idx, ref;
    this.resetPilot();
    this.resetAddons();
    this.teardownUI();
    idx = this.builder.ships.indexOf(this);
    if (idx < 0) {
      throw new Error("Ship not registered with builder");
    }
    this.builder.ships.splice(idx, 1);
    // remove all wingmates, if we are wingleader
    if (this.wingmates.length > 0) {
      this.setWingmates(0);
    }
    // check if there is a linked ship
    if (this.linkedShip !== null) {
      // remove us from the wing, if we are part of a wing
      if (((ref = this.linkedShip.wingmates) != null ? ref.length : void 0) > 0 && indexOf.call(this.linkedShip.wingmates, this) >= 0) {
        this.linkedShip.removeFromWing(this);
      } else {
        // unlink us from the linked ship, so we are not in a infinite recursive trap (it will otherwise attempt to remove us)
        // we are not part of a wing, so we just want to also remove the linked ship
        this.linkedShip.linkedShip = null;
        await new Promise((resolve, reject) => {
          return this.builder.removeShip(this.linkedShip, resolve);
        });
      }
    }
    return cb();
  }

  async copyFrom(other) {
    var available_pilots, delayed_upgrades, id, j, l, len, len1, len2, len3, m, name1, no_uniques_involved, o, other_upgrade, other_upgrades, pilot_data, ref, ref1, ref2, ref3, ref4, ref5, ref6, ref7, ref8, upgrade;
    if (other === this) {
      throw new Error("Cannot copy from self");
    }
    //console.log "Attempt to copy #{other?.pilot?.name}"
    if (!((other.pilot != null) && (other.data != null))) {
      return;
    }
    //console.log "Setting pilot to ID=#{other.pilot.id}"
    if (this.builder.isQuickbuild) {
      // check if pilot is unique. In that case the whole ship may not be copied, but the cheapest alternative will be selected
      no_uniques_involved = !(other.pilot.unique || ((other.pilot.max_per_squad != null) && this.builder.countPilots(other.pilot.canonical_name) >= other.pilot.max_per_squad));
      if (no_uniques_involved) {
        ref = other.upgrades;
        // also check all upgrades
        for (j = 0, len = ref.length; j < len; j++) {
          upgrade = ref[j];
          if (((((ref1 = upgrade.data) != null ? ref1.unique : void 0) != null) && upgrade.data.unique) || ((((ref2 = upgrade.data) != null ? ref2.max_per_squad : void 0) != null) && this.builder.countUpgrades(upgrade.data.canonical_name) >= upgrade.data.max_per_squad) || (((ref3 = upgrade.data) != null ? ref3.solitary : void 0) != null)) {
            no_uniques_involved = false;
          }
        }
      }
      if (no_uniques_involved) {
        // still no uniques, so we can copy that ship as is
        this.setPilotById(other.quickbuildId);
      } else {
        // try to select another pilot for the same ship instead
        available_pilots = (function() {
          var l, len1, ref4, results1;
          ref4 = this.builder.getAvailablePilotsForShipIncluding(other.data.name);
          results1 = [];
          for (l = 0, len1 = ref4.length; l < len1; l++) {
            pilot_data = ref4[l];
            if (!pilot_data.disabled) {
              results1.push(pilot_data);
            }
          }
          return results1;
        }).call(this);
        if (available_pilots.length > 0) {
          this.setPilotById(available_pilots[0].id, true);
        } else {
          return;
        }
      }
    } else {
      if (other.pilot.unique || ((other.pilot.max_per_squad != null) && this.builder.countPilots(other.pilot.canonical_name) >= other.pilot.max_per_squad)) {
        // Look for cheapest generic or available unique, otherwise do nothing
        available_pilots = (function() {
          var l, len1, ref4, results1;
          ref4 = this.builder.getAvailablePilotsForShipIncluding(other.data.name);
          results1 = [];
          for (l = 0, len1 = ref4.length; l < len1; l++) {
            pilot_data = ref4[l];
            if (!pilot_data.disabled) {
              results1.push(pilot_data);
            }
          }
          return results1;
        }).call(this);
        if (available_pilots.length > 0) {
          await this.setPilotById(available_pilots[0].id, true);
        } else {
          return;
        }
      } else {
        await this.setPilotById(other.pilot.id, true);
      }
      // filter out upgrades that can be copied
      other_upgrades = {};
      ref4 = other.upgrades;
      for (l = 0, len1 = ref4.length; l < len1; l++) {
        upgrade = ref4[l];
        if (((upgrade != null ? upgrade.data : void 0) != null) && !upgrade.isStandardized() && (upgrade.data.standard == null) && !upgrade.data.unique && ((upgrade.data.max_per_squad == null) || this.builder.countUpgrades(upgrade.data.canonical_name) < upgrade.data.max_per_squad)) {
          if (other_upgrades[name1 = upgrade.slot] == null) {
            other_upgrades[name1] = [];
          }
          other_upgrades[upgrade.slot].push(upgrade);
        }
      }
      // set them aside any upgrades that don't fill requirements due to additional slots and then attempt to fill them
      delayed_upgrades = {};
      ref5 = this.upgrades;
      for (m = 0, len2 = ref5.length; m < len2; m++) {
        upgrade = ref5[m];
        if (!upgrade.isOccupied()) { // an earlier set double-slot upgrade may already use this slot
          other_upgrade = ((ref6 = other_upgrades[upgrade.slot]) != null ? ref6 : []).shift();
          if (other_upgrade != null) {
            await upgrade.setById(other_upgrade.data.id);
            // it would be cool if upgrade.setById would return whether it succeeded (as promise), so we could attempt to add all
            // upgrades, wait for all promises to resolve, and then retry the rejected upgrades. Instead, we wait for each upgrade individually.
            if (!upgrade.lastSetValid) {
              delayed_upgrades[other_upgrade.data.id] = upgrade;
            }
          }
        }
      }
      for (id in delayed_upgrades) {
        upgrade = delayed_upgrades[id];
        upgrade.setById(id);
      }
      ref7 = this.upgrades;
      // Do one final pass on upgrades to see if there are any more upgrades we can assign
      for (o = 0, len3 = ref7.length; o < len3; o++) {
        upgrade = ref7[o];
        if (!upgrade.isOccupied()) {
          other_upgrade = ((ref8 = other_upgrades[upgrade.slot]) != null ? ref8 : []).shift();
          if (other_upgrade != null) {
            upgrade.setById(other_upgrade.data.id);
          }
        }
      }
      this.addStandardizedUpgrades();
    }
    this.updateSelections();
    this.builder.container.trigger('xwing:pointsUpdated');
    this.builder.current_squad.dirty = true;
    return this.builder.container.trigger('xwing-backend:squadDirtinessChanged');
  }

  setShipType(ship_type) {
    var cls, j, len, quickbuild_id, ref, ref1, result;
    this.pilot_selector.data('select2').container.show();
    if (ship_type !== ((ref = this.pilot) != null ? ref.ship : void 0)) {
      if (!this.builder.isQuickbuild) {
        this.setPilot(((function() {
          var j, len, ref1, ref2, results1;
          ref1 = this.builder.getAvailablePilotsForShipIncluding(ship_type);
          results1 = [];
          for (j = 0, len = ref1.length; j < len; j++) {
            result = ref1[j];
            if (((exportObj.pilotsById[result.id].restriction_func == null) || exportObj.pilotsById[result.id].restriction_func(this)) && !(ref2 = exportObj.pilotsById[result.id], indexOf.call(this.builder.uniques_in_use.Pilot, ref2) >= 0)) {
              results1.push(exportObj.pilotsById[result.id]);
            }
          }
          return results1;
        }).call(this))[0]);
      } else {
        // get the first available pilot
        quickbuild_id = ((function() {
          var j, len, ref1, results1;
          ref1 = this.builder.getAvailablePilotsForShipIncluding(ship_type);
          results1 = [];
          for (j = 0, len = ref1.length; j < len; j++) {
            result = ref1[j];
            if (!result.disabled) {
              results1.push(result.id);
            }
          }
          return results1;
        }).call(this))[0];
        this.setPilotById(quickbuild_id);
      }
    }
    this.checkPilotSelectorQueryModal();
    ref1 = this.row.attr('class').split(/\s+/);
    
    // Clear ship background class
    for (j = 0, len = ref1.length; j < len; j++) {
      cls = ref1[j];
      if (cls.indexOf('ship-') === 0) {
        this.row.removeClass(cls);
      }
    }
    // Show delete button
    this.remove_button.fadeIn('fast');
    this.copy_button.fadeIn('fast');
    if (this.builder.show_points_destroyed === true) {
      this.points_destroyed_button.fadeIn('fast');
    }
    // Ship background, Commented out to comply with AMG policies
    // @row.addClass "ship-#{ship_type.toLowerCase().replace(/[^a-z0-9]/gi, '')}"
    return this.builder.container.trigger('xwing:shipUpdated');
  }

  async setPilotById(id, noautoequip = false) {
    var j, len, new_pilot, quickbuild, ref, ref1, ship;
    //sets pilot of this ship according to given id. Id might be pilotId or quickbuildId depending on mode. 
    if (!this.builder.isQuickbuild) {
      return this.setPilot(exportObj.pilotsById[parseInt(id)], noautoequip);
    } else {
      if (id !== this.quickbuildId) {
        this.wingmate_selector.parent().hide();
        if ((this.wingmates != null) && this.wingmates.length > 0) {
          // remove any wingmates, as the wing leader was just removed from the list
          this.setWingmates(0);
        }
        // @linkedShip = null the ghost hera has wingmates and a linked phantom. We can't assume that we are done here...
        this.quickbuildId = id;
        this.builder.current_squad.dirty = true;
        this.resetPilot();
        this.resetAddons();
        if ((id != null) && id > -1) {
          quickbuild = exportObj.quickbuildsById[parseInt(id)];
          new_pilot = exportObj.pilots[quickbuild.pilot];
          this.data = exportObj.ships[quickbuild.ship];
          this.builder.isUpdatingPoints = true; // prevents unneccesary validations while still adding stuff
          if ((new_pilot != null ? new_pilot.unique : void 0) != null) {
            await new Promise((resolve, reject) => {
              return this.builder.container.trigger('xwing:claimUnique', [new_pilot, 'Pilot', resolve]);
            });
          }
          this.pilot = new_pilot;
          if (this.pilot != null) {
            this.setupAddons();
          }
          this.copy_button.show();
          this.setShipType(this.pilot.ship);
          // if this card contains more than one ship, make sure the other one is added as well
          if ((quickbuild.wingmate != null) && (this.linkedShip == null)) {
            ref = this.builder.ships;
            // try to join wingleader, if we have not been created by him
            for (j = 0, len = ref.length; j < len; j++) {
              ship = ref[j];
              if (ship.quickbuildId === quickbuild.linkedId) {
                // found our leader. join him.
                ship.joinWing(this);
                this.linkedShip = ship;
                this.primary = false;
                this.builder.isUpdatingPoints = false;
                this.builder.container.trigger('xwing:pointsUpdated');
                this.builder.container.trigger('xwing-backend:squadDirtinessChanged'); // we are done.
                return;
              }
            }
          }
          if (this.linkedShip) {
            // we are already linked to some other ship
            if (quickbuild.linkedId != null) {
              
              // we will stay linked to another ship, so just set the linked one to an new pilot es well
              this.linkedShip.setPilotById(quickbuild.linkedId);
              if (quickbuild.wingmate == null) {
                this.linkedShip.primary = false;
              }
            } else {
              // take care of associated ship
              if (((ref1 = this.linkedShip.wingmates) != null ? ref1.length : void 0) > 0) {
                // we are no longer part of a wing
                this.linkedShip.removeFromWing(this);
              } else {
                // we are no longer part of a linked pair, so the linked ship should be removed
                this.linkedShip.linkedShip = null;
                await new Promise((resolve, reject) => {
                  return this.builder.removeShip(this.linkedShip, resolve);
                });
              }
              this.linkedShip = null;
            }
          } else if (quickbuild.linkedId != null) {
            // we nare not already linked to another ship, but need one. Let's set one up
            this.linkedShip = this.builder.ships.slice(-1)[0];
            // during squad building there is an empty ship at the bottom, use that one and add a new empty one. 
            // during squad loading there is no empty ship at the bottom, so we just create a new one and use it
            if (this.linkedShip.data !== null) {
              this.linkedShip = this.builder.addShip();
            } else {
              this.builder.addShip();
            }
            this.linkedShip.linkedShip = this;
            this.linkedShip.setPilotById(quickbuild.linkedId);
            if (quickbuild.wingmate == null) {
              // for pairs the first selected ship is master, so as we have been created first, we set the other ship to false
              // for wings the wingleader is always master, so we don't set the other ship to false, if we are just a wingmate
              this.linkedShip.primary = false;
            }
          }
          this.primary = quickbuild.wingmate == null;
          if ((quickbuild != null ? quickbuild.wingleader : void 0) != null) {
            this.wingmate_selector.parent().show();
            this.wingmate_selector.val(quickbuild.wingmates[0]);
            this.wingmate_selector.attr("min", quickbuild.wingmates[0]);
            this.wingmate_selector.attr("max", quickbuild.wingmates[quickbuild.wingmates.length - 1]);
            this.setWingmates(quickbuild.wingmates[0]);
          }
          this.builder.isUpdatingPoints = false;
          this.builder.container.trigger('xwing:pointsUpdated');
        } else {
          this.copy_button.hide();
        }
        this.row.removeClass('unsortable');
        this.builder.container.trigger('xwing:pointsUpdated');
        return this.builder.container.trigger('xwing-backend:squadDirtinessChanged');
      }
    }
  }

  addStandardizedUpgrades() {
    var idx, j, l, len, len1, ref, ref1, ref2, ref3, restrictions, upgrade, upgrade_to_be_equipped;
    if (this.hasFixedUpgrades) { // standard ships bypass
      return;
    }
    idx = this.builder.standard_list['Ship'].indexOf((ref = this.data) != null ? ref.name : void 0);
    if (idx > -1) {
      upgrade_to_be_equipped = this.builder.standard_list['Upgrade'][idx];
      restrictions = (upgrade_to_be_equipped.restrictions ? upgrade_to_be_equipped.restrictions : void 0);
      ref1 = this.upgrades;
      // first check if we already have that upgrade equipped. No need to do anything if we do. 
      for (j = 0, len = ref1.length; j < len; j++) {
        upgrade = ref1[j];
        if (((ref2 = upgrade.data) != null ? ref2.name : void 0) === upgrade_to_be_equipped.name) {
          return;
        }
      }
      ref3 = this.upgrades;
      // now look for empty slots that could be equipped
      for (l = 0, len1 = ref3.length; l < len1; l++) {
        upgrade = ref3[l];
        if (exportObj.slotsMatching(upgrade.slot, this.builder.standard_list['Upgrade'][idx].slot)) {
          if (this.restriction_check(restrictions, upgrade) && (upgrade.data == null)) {
            upgrade.setData(upgrade_to_be_equipped);
            return;
          }
        }
      }
    }
  }

  addToStandardizedList(upgrade_data) {
    var idx, ref;
    // check first if standard combo exists and return if it does
    idx = this.builder.standard_list['Ship'].indexOf(this.data.name);
    if (idx > -1) {
      if (((ref = this.builder.standard_list['Upgrade'][idx]) != null ? ref.name : void 0) === upgrade_data.name) {
        return;
      }
    }
    this.builder.standard_list['Upgrade'].push(upgrade_data);
    return this.builder.standard_list['Ship'].push(this.data.name);
  }

  removeStandardizedList(upgrade_data) {
    var idx, j, len, ref, ref1, ref2, results1, ship, upgrade;
    // removes the ship upgrade combo from the stanard list array
    idx = this.builder.standard_list['Ship'].indexOf(this.data.name);
    if (idx > -1) {
      if (((ref = this.builder.standard_list['Upgrade'][idx]) != null ? ref.name : void 0) === upgrade_data.name) {
        this.builder.standard_list['Upgrade'].splice(idx, 1);
        this.builder.standard_list['Ship'].splice(idx, 1);
        ref1 = this.builder.ships;
        
        // now remove all upgrades of the same name
        results1 = [];
        for (j = 0, len = ref1.length; j < len; j++) {
          ship = ref1[j];
          if (((ref2 = ship.data) != null ? ref2.name : void 0) === this.data.name && ship !== this) {
            results1.push((function() {
              var l, len1, ref3, ref4, results2;
              ref3 = ship.upgrades;
              results2 = [];
              for (l = 0, len1 = ref3.length; l < len1; l++) {
                upgrade = ref3[l];
                if (((ref4 = upgrade.data) != null ? ref4.name : void 0) === upgrade_data.name) {
                  upgrade.setData(null);
                  break;
                } else {
                  results2.push(void 0);
                }
              }
              return results2;
            })());
          } else {
            results1.push(void 0);
          }
        }
        return results1;
      }
    }
  }

  checkStandardizedList(ship_name) {
    var idx, ref;
    // check first if standard combo exists and return if it does
    idx = this.builder.standard_list['Ship'].indexOf(ship_name);
    if (idx > -1) {
      if (((ref = this.builder.standard_list['Upgrade'][idx]) != null ? ref.name : void 0) != null) {
        return this.builder.standard_list['Upgrade'][idx];
      }
    } else {
      return void 0;
    }
  }

  async setPilot(new_pilot, noautoequip = false) {
    var _, auto_equip_upgrade, autoequip, delayed_upgrades, id, j, l, len, len1, len2, len3, len4, m, name1, o, old_upgrade, old_upgrades, q, ref, ref1, ref2, ref3, ref4, ref5, ref6, ref7, same_ship, standard_check, standard_upgrade_to_check, upgrade, upgrade_name, y;
    // don't call this method directly, unless you know what you do. Use setPilotById for proper quickbuild handling
    if (new_pilot !== this.pilot || (this.builder.isXwa && !this.usesxwaSlots && (this.pilot.slotsxwa != null)) || (this.usesxwaSlots && !this.builder.isXwa)) {
      this.builder.current_squad.dirty = true;
      same_ship = (this.pilot != null) && (new_pilot != null ? new_pilot.ship : void 0) === this.pilot.ship;
      old_upgrades = {};
      if (same_ship && (this.pilot.upgrades == null)) {
        ref = this.upgrades;
        // track addons and try to reassign them
        for (j = 0, len = ref.length; j < len; j++) {
          upgrade = ref[j];
          if ((upgrade != null ? upgrade.data : void 0) != null) {
            if (old_upgrades[name1 = upgrade.slot] == null) {
              old_upgrades[name1] = [];
            }
            old_upgrades[upgrade.slot].push(upgrade.data.id);
          }
        }
      }
      await this.resetPilot();
      await this.resetAddons();
      if (new_pilot != null) {
        this.data = exportObj.ships[new_pilot != null ? new_pilot.ship : void 0];
        if ((new_pilot != null ? new_pilot.unique : void 0) != null) {
          await new Promise((resolve, reject) => {
            return this.builder.container.trigger('xwing:claimUnique', [new_pilot, 'Pilot', resolve]);
          });
        }
        this.pilot = new_pilot;
        if (this.pilot != null) {
          this.setupAddons();
        }
        this.copy_button.show();
        this.setShipType(this.pilot.ship);
        if (((this.pilot.autoequip != null) || ((exportObj.ships[this.pilot.ship].autoequip != null) && !same_ship)) && !noautoequip) {
          autoequip = ((ref2 = this.pilot.autoequip) != null ? ref2 : []).concat((ref1 = exportObj.ships[this.pilot.ship].autoequip) != null ? ref1 : []);
          for (l = 0, len1 = autoequip.length; l < len1; l++) {
            upgrade_name = autoequip[l];
            auto_equip_upgrade = exportObj.upgrades[upgrade_name];
            ref3 = this.upgrades;
            for (m = 0, len2 = ref3.length; m < len2; m++) {
              upgrade = ref3[m];
              if (exportObj.slotsMatching(upgrade.slot, auto_equip_upgrade.slot)) {
                upgrade.setData(auto_equip_upgrade);
              }
            }
          }
        }
        if (same_ship && (this.pilot.upgrades == null)) {
// two cycles, in case an old upgrade is adding slots that are required for other old upgrades
          for (_ = o = 1; o <= 2; _ = ++o) {
            delayed_upgrades = {};
            ref4 = this.upgrades;
            for (q = 0, len3 = ref4.length; q < len3; q++) {
              upgrade = ref4[q];
              // check if there exits old upgrades for this slot - if so, try to add the first of them
              old_upgrade = ((ref5 = old_upgrades[upgrade.slot]) != null ? ref5 : []).shift();
              if (old_upgrade != null) {
                await upgrade.setById(old_upgrade);
                if (!upgrade.lastSetValid) {
                  // failed to add an upgrade, even though the required slot was there - retry later
                  // perhaps another card is providing an required restriction (e.g. an action)
                  delayed_upgrades[old_upgrade] = upgrade;
                }
              }
            }
            for (id in delayed_upgrades) {
              upgrade = delayed_upgrades[id];
              upgrade.setById(id);
            }
          }
          // last check for standardized
          // see if ship is supposed to be standardized
          standard_upgrade_to_check = this.checkStandardizedList(this.pilot.ship);
          standard_check = false;
          ref6 = this.upgrades;
          for (y = 0, len4 = ref6.length; y < len4; y++) {
            upgrade = ref6[y];
            if ((standard_upgrade_to_check != null) && (((upgrade != null ? (ref7 = upgrade.data) != null ? ref7.name : void 0 : void 0) != null) && (upgrade.data.name === standard_upgrade_to_check.name))) {
              standard_check = true;
            }
          }
          if ((standard_upgrade_to_check != null) && (standard_check === false)) {
            this.removeStandardizedList(standard_upgrade_to_check);
          }
        }
      } else {
        this.copy_button.hide();
      }
      this.row.removeClass('unsortable');
      this.builder.container.trigger('xwing:pointsUpdated');
      return this.builder.container.trigger('xwing-backend:squadDirtinessChanged');
    }
  }

  async resetPilot() {
    var ref;
    if (((ref = this.pilot) != null ? ref.unique : void 0) != null) {
      await new Promise((resolve, reject) => {
        return this.builder.container.trigger('xwing:releaseUnique', [this.pilot, 'Pilot', resolve]);
      });
    }
    return this.pilot = null;
  }

  setupAddons() {
    var j, l, len, len1, len2, m, pilotslots, ref, ref1, ref2, ref3, ref4, results1, results2, results3, slot, upgrade, upgrade_data, upgrade_name;
    if (!this.builder.isQuickbuild) {
      if (this.pilot.upgrades != null) {
        this.hasFixedUpgrades = true;
        this.usesxwaSlots = false;
        ref1 = (ref = this.pilot.upgrades) != null ? ref : [];
        results1 = [];
        for (j = 0, len = ref1.length; j < len; j++) {
          upgrade_name = ref1[j];
          upgrade_data = exportObj.upgrades[upgrade_name];
          if (upgrade_data == null) {
            console.log("Unknown Upgrade: " + upgrade_name);
            continue;
          }
          upgrade = new exportObj.QuickbuildUpgrade({
            ship: this,
            container: this.addon_container,
            slot: upgrade_data.slot,
            upgrade: upgrade_data
          });
          upgrade.setData(upgrade_data);
          results1.push(this.upgrades.push(upgrade));
        }
        return results1;
      } else {
        this.hasFixedUpgrades = false;
        if (this.builder.isXwa && (this.pilot.slotsxwa != null)) {
          pilotslots = this.pilot.slotsxwa;
          this.usesxwaSlots = true;
        } else {
          this.usesxwaSlots = false;
          pilotslots = this.pilot.slots;
        }
        ref2 = pilotslots != null ? pilotslots : [];
        results2 = [];
        for (l = 0, len1 = ref2.length; l < len1; l++) {
          slot = ref2[l];
          results2.push(this.upgrades.push(new exportObj.Upgrade({
            ship: this,
            container: this.addon_container,
            slot: slot
          })));
        }
        return results2;
      }
    } else {
      ref4 = (ref3 = exportObj.quickbuildsById[this.quickbuildId].upgrades) != null ? ref3 : [];
      
      // Upgrades from quickbuild
      results3 = [];
      for (m = 0, len2 = ref4.length; m < len2; m++) {
        upgrade_name = ref4[m];
        upgrade_data = exportObj.upgrades[upgrade_name];
        if (upgrade_data == null) {
          console.log("Unknown Upgrade: " + upgrade_name);
          continue;
        }
        upgrade = new exportObj.QuickbuildUpgrade({
          ship: this,
          container: this.addon_container,
          slot: upgrade_data.slot,
          upgrade: upgrade_data
        });
        upgrade.setData(upgrade_data);
        results3.push(this.upgrades.push(upgrade));
      }
      return results3;
    }
  }

  resetAddons() {
    var j, len, ref, upgrade, upgrades_destroyed;
    upgrades_destroyed = [];
    ref = this.upgrades;
    for (j = 0, len = ref.length; j < len; j++) {
      upgrade = ref[j];
      if (upgrade != null) {
        upgrades_destroyed.push(new Promise((resolve, reject) => {
          return upgrade.destroy(resolve);
        }));
      }
    }
    return Promise.all(upgrades_destroyed).then(this.upgrades = []);
  }

  getPoints() {
    var effective_stats, loadout, points, quickbuild, ref, ref1, threat;
    if (!this.builder.isQuickbuild) {
      if (this.pilot != null) {
        effective_stats = this.effectiveStats();
        points = effective_stats != null ? effective_stats.points : void 0;
        loadout = effective_stats != null ? effective_stats.loadout : void 0;
      } else {
        points = 0;
        loadout = 0;
      }
      this.points_container.find('div').text(`${points}`);
      this.points_container.find('.upgrade-points').text(((ref = this.pilot) != null ? ref.loadout : void 0) != null ? `(${this.upgrade_points_total}/${loadout})` : "");
      if (points > 0) {
        this.points_container.fadeTo('fast', 1);
      } else {
        this.points_container.fadeTo(0, 0);
      }
      return points;
    } else {
      quickbuild = exportObj.quickbuildsById[this.quickbuildId];
      threat = this.primary ? (ref1 = quickbuild != null ? quickbuild.threat : void 0) != null ? ref1 : 0 : 0;
      if ((quickbuild != null ? quickbuild.wingleader : void 0) != null) {
        threat = quickbuild.threat[quickbuild.wingmates.indexOf(this.wingmates.length)];
      }
      this.points_container.find('span').text(threat);
      if (threat > 0) {
        this.points_container.fadeTo('fast', 1);
      } else {
        this.points_container.fadeTo(0, 0);
      }
      return threat;
    }
  }

  async setWingmates(wingmates) {
    var dyingMate, newMate, quickbuild, ref;
    // creates/destroys wingmates to match number given as argument
    // todo: Check if number is valid for this quickbuild wing?
    if (((ref = this.wingmates) != null ? ref.length : void 0) === wingmates) {
      return;
    }
    if ((this.wingmates == null) || this.wingmates.length === 0) {
      // if no wingmates are set yet, create an empty list
      this.wingmates = [];
    }
    quickbuild = exportObj.quickbuildsById[this.quickbuildId];
    while (this.wingmates.length < wingmates) {
      
      // create more wingmates
      newMate = this.builder.ships.slice(-1)[0];
      // during squad building there is an empty ship at the bottom, use that one and add a new empty one. 
      // during squad loading there is no empty ship at the bottom, so we just create a new one and use it
      if (newMate.data !== null) {
        newMate = this.builder.addShip();
      } else {
        this.builder.addShip();
      }
      newMate.linkedShip = this; // link new mate to us
      this.wingmates.push(newMate);
      newMate.setPilotById(quickbuild.wingmateId);
      // for pairs the first selected ship is master, so as we have been created first, we set the other ship to false
      // for wings the wingleader is always master, so we don't set the other ship to false, if we are just a wingmate
      newMate.primary = false;
      this.primary = true; // he should not try to steal our primary position, as he is aware of beeing not squad leader, but in case he's not just set it. 
    }
    while (this.wingmates.length > wingmates) {
      // destroy wingmates
      dyingMate = this.wingmates.pop();
      dyingMate.linkedShip = null; // prevent the mate from killing us
      await new Promise((resolve, reject) => {
        return this.builder.removeShip(dyingMate, resolve);
      });
    }
    return this.wingmate_selector.val(wingmates);
  }

  removeFromWing(ship) {
    var quickbuild, ref;
    // remove requested ship from wing
    this.wingmates.removeItem(ship);
    // check if the wing is still valid, otherwise destroy it. 
    quickbuild = exportObj.quickbuildsById[this.quickbuildId];
    if (!(ref = this.wingmates.length, indexOf.call(quickbuild.wingmates, ref) >= 0)) {
      this.destroy($.noop);
    }
    return this.wingmate_selector.val(this.wingmates.length);
  }

  joinWing(ship) {
    var quickbuild, ref;
    // remove requested ship from wing
    this.wingmates.push(ship);
    // check if the wing is still valid, otherwise destroy the added ship
    quickbuild = exportObj.quickbuildsById[this.quickbuildId];
    if (!(ref = this.wingmates.length, indexOf.call(quickbuild.wingmates, ref) >= 0)) {
      ship.destroy($.noop);
      this.removeFromWing(ship);
    }
    return this.wingmate_selector.val(this.wingmates.length);
  }

  updateSelections() {
    var j, len, points, ref, ref1, results1, upgrade;
    if (this.pilot != null) {
      this.ship_selector.select2('data', {
        id: this.pilot.ship,
        text: exportObj.ships[this.pilot.ship].display_name ? exportObj.ships[this.pilot.ship].display_name : this.pilot.ship,
        chassis: exportObj.ships[this.pilot.ship].chassis ? exportObj.ships[this.pilot.ship].chassis : "",
        xws: exportObj.ships[this.pilot.ship].name.canonicalize(),
        icon: exportObj.ships[this.pilot.ship].icon ? exportObj.ships[this.pilot.ship].icon : exportObj.ships[this.pilot.ship].name.canonicalize()
      });
      this.pilot_selector.select2('data', {
        id: this.pilot.id,
        text: `${(((ref = exportObj.settings) != null ? ref.initiative_prefix : void 0) != null) && exportObj.settings.initiative_prefix ? this.pilot.skill + ' - ' : ''}${this.pilot.display_name ? this.pilot.display_name : this.pilot.name}${this.quickbuildId !== -1 ? exportObj.quickbuildsById[this.quickbuildId].suffix : ""} (${this.quickbuildId !== -1 ? (this.primary ? exportObj.quickbuildsById[this.quickbuildId].threat : 0) : ((this.builder.isXwa && (this.pilot.pointsxwa != null)) ? this.pilot.pointsxwa : this.pilot.points)}${(this.quickbuildId !== -1 || (this.pilot.loadout == null)) ? "" : (this.builder.isXwa && (this.pilot.loadoutxwa != null) ? `/${this.pilot.loadoutxwa}` : `/${this.pilot.loadout}`)})`,
        chassis: this.pilot.chassis != null ? this.pilot.chassis : ""
      });
      this.pilot_selector.data('select2').container.show();
      ref1 = this.upgrades;
      results1 = [];
      for (j = 0, len = ref1.length; j < len; j++) {
        upgrade = ref1[j];
        points = upgrade.getPoints();
        results1.push(upgrade.updateSelection(points));
      }
      return results1;
    } else {
      return this.pilot_selector.select2('data', null);
    }
  }

  //@pilot_selector.data('select2').container.toggle(@ship_selector.val() != '')
  checkPilotSelectorQueryModal() {
    if ($(window).width() >= 768) {
      return this.pilot_query_modal.hide();
    } else {
      if (this.pilot) {
        return this.pilot_query_modal.show();
      }
    }
  }

  setupUI() {
    var shipResultFormatter, shipSelectionFormatter;
    this.row = $(document.createElement('DIV'));
    this.row.addClass('row ship mb-5 mb-sm-0 unsortable');
    this.row.insertBefore(this.builder.notes_container);
    this.row.append($.trim(`<div class="col-md-3">
    <div class="form-group d-flex">
        <input class="ship-selector-container" type="hidden"></input>
        <div class="d-block d-md-none input-group-append">
            <button class="btn btn-secondary ship-query-modal"><i class="fas fa-question"></i></button>
        </div>
    <br />
    </div>
    <div class="form-group d-flex">
        <input type="hidden" class="pilot-selector-container"></input>
        <div class="d-block d-md-none input-group-append">
            <button class="btn btn-secondary pilot-query-modal"><i class="fas fa-question"></i></button>
        <br />
        </div>
    </div>
    <label class="wingmate-label">
    ${this.uitranslation("Wingmates")}: 
        <input type="number" class="wingmate-selector"></input>
    </label>
</div>
<div class="col-md-1 points-display-container">
     <div></div>
     <div class="upgrade-points"></div>
</div>
<div class="col-md-6 addon-container">  </div>
<div class="col-md-2 button-container">
    <button class="btn btn-danger remove-pilot side-button"><span class="d-none d-sm-block" data-toggle="tooltip" title="${this.uitranslation("Remove Pilot")}"><i class="fa fa-times"></i></span><span class="d-block d-sm-none"> ${this.uitranslation("Remove Pilot")}</span></button>
    <button class="btn btn-light copy-pilot side-button"><span class="d-none d-sm-block" data-toggle="tooltip" title="${this.uitranslation("Clone Pilot")}"><i class="far fa-copy"></i></span><span class="d-block d-sm-none"> ${this.uitranslation("Clone Pilot")}</span></button>
    <button class="btn btn-light points-destroyed side-button" points-state"><span class="d-none d-sm-block destroyed-type" data-toggle="tooltip" title="${this.uitranslation("Points Destroyed")}"><i class="fas fa-circle"></i></i></span><span class="d-block d-sm-none destroyed-type-mobile"> ${this.uitranslation("Undamaged")}</span></button>
</div>`));
    this.row.find('.button-container span').tooltip();
    this.ship_selector = $(this.row.find('input.ship-selector-container'));
    this.pilot_selector = $(this.row.find('input.pilot-selector-container'));
    this.wingmate_selector = $(this.row.find('input.wingmate-selector'));
    this.ship_query_modal = $(this.row.find('button.ship-query-modal'));
    this.pilot_query_modal = $(this.row.find('button.pilot-query-modal'));
    this.ship_query_modal.click((e) => {
      if (this.pilot) {
        this.builder.showTooltip('Ship', exportObj.ships[this.pilot.ship], null, this.builder.mobile_tooltip_modal, true);
        return this.builder.mobile_tooltip_modal.modal('show');
      }
    });
    this.pilot_query_modal.click((e) => {
      if (this.pilot) {
        this.builder.showTooltip('Pilot', this.pilot, (this.pilot ? this : void 0), this.builder.mobile_tooltip_modal, true);
        return this.builder.mobile_tooltip_modal.modal('show');
      }
    });
    shipResultFormatter = function(object, container, query) {
      return `<i class="xwing-miniatures-ship xwing-miniatures-ship-${object.icon}"></i> ${object.text}`;
    };
    shipSelectionFormatter = function(object, container) {
      return `<i class="xwing-miniatures-ship xwing-miniatures-ship-${object.icon}"></i> ${object.text}`;
    };
    this.ship_selector.select2({
      width: '100%',
      placeholder: exportObj.translate('ui', 'shipSelectorPlaceholder'),
      query: (query) => {
        var data;
        data = {
          results: []
        };
        data.results = this.builder.getAvailableShipsMatching(query.term);
        return query.callback(data);
      },
      minimumResultsForSearch: $.isMobile() ? -1 : 0,
      formatResultCssClass: (obj) => {
        var not_in_collection;
        if ((this.builder.collection != null) && (this.builder.collection.checks.collectioncheck === "true")) {
          not_in_collection = false;
          if ((this.pilot != null) && obj.id === exportObj.ships[this.pilot.ship].id) {
            // Currently selected ship; mark as not in collection if it's neither
            // on the shelf nor on the table
            if (!(this.builder.collection.checkShelf('ship', obj.name) || this.builder.collection.checkTable('pilot', obj.name))) {
              not_in_collection = true;
            }
          } else {
            // Not currently selected; check shelf only
            not_in_collection = !this.builder.collection.checkShelf('ship', obj.name);
          }
          if (not_in_collection) {
            return 'select2-result-not-in-collection';
          } else {
            return '';
          }
        } else {
          return '';
        }
      },
      formatResult: shipResultFormatter,
      formatSelection: shipResultFormatter
    });
    this.ship_selector.on('select2-focus', (e) => {
      if ($.isMobile()) {
        $('.select2-container .select2-focusser').remove();
        return $('.select2-search input').prop('focus', false).removeClass('select2-focused');
      }
    });
    this.ship_selector.on('change', (e) => {
      return this.setShipType(this.ship_selector.val());
    });
    this.ship_selector.data('select2').results.on('mousemove-filtered', (e) => {
      var select2_data;
      select2_data = $(e.target).closest('.select2-result').data('select2-data');
      if ((select2_data != null ? select2_data.id : void 0) != null) {
        return this.builder.showTooltip('Ship', exportObj.ships[select2_data.id]);
      }
    });
    this.ship_selector.data('select2').container.on('mouseover', (e) => {
      if (this.pilot) {
        return this.builder.showTooltip('Ship', exportObj.ships[this.pilot.ship]);
      }
    });
    this.pilot_selector.select2({
      width: '100%',
      placeholder: exportObj.translate('ui', 'pilotSelectorPlaceholder'),
      query: (query) => {
        var data;
        data = {
          results: []
        };
        data.results = this.builder.getAvailablePilotsForShipIncluding(this.ship_selector.val(), (!this.builder.isQuickbuild ? this.pilot : this.quickbuildId), query.term, true, this);
        return query.callback(data);
      },
      minimumResultsForSearch: $.isMobile() ? -1 : 0,
      formatResultCssClass: (obj) => {
        var name, not_in_collection, ref, ref1, ref2;
        if ((this.builder.collection != null) && (this.builder.collection.checks.collectioncheck === "true")) {
          not_in_collection = false;
          name = "";
          if (this.builder.isQuickbuild) {
            name = (ref = (ref1 = exportObj.quickbuildsById[obj.id]) != null ? ref1.pilot : void 0) != null ? ref : "unknown pilot";
          } else {
            name = obj.name;
          }
          if (obj.id === ((ref2 = this.pilot) != null ? ref2.id : void 0)) {
            // Currently selected pilot; mark as not in collection if it's neither
            // on the shelf nor on the table
            if (!(this.builder.collection.checkShelf('pilot', name) || this.builder.collection.checkTable('pilot', name))) {
              not_in_collection = true;
            }
          } else {
            // Not currently selected; check shelf only
            not_in_collection = !this.builder.collection.checkShelf('pilot', name);
          }
          if (not_in_collection) {
            return 'select2-result-not-in-collection';
          } else {
            return '';
          }
        } else {
          return '';
        }
      }
    });
    this.pilot_selector.on('select2-focus', (e) => {
      if ($.isMobile()) {
        $('.select2-container .select2-focusser').remove();
        return $('.select2-search input').prop('focus', false).removeClass('select2-focused');
      }
    });
    this.pilot_selector.on('change', (e) => {
      this.setPilotById(this.pilot_selector.select2('val'));
      this.builder.current_squad.dirty = true;
      this.builder.container.trigger('xwing-backend:squadDirtinessChanged');
      return this.builder.backend_status.fadeOut('slow');
    });
    this.pilot_selector.data('select2').results.on('mousemove-filtered', (e) => {
      var ref, select2_data;
      select2_data = $(e.target).closest('.select2-result').data('select2-data');
      if (this.builder.isQuickbuild) {
        if ((select2_data != null ? select2_data.id : void 0) != null) {
          return this.builder.showTooltip('Quickbuild', exportObj.quickbuildsById[select2_data.id], {
            ship: (ref = this.data) != null ? ref.name : void 0
          });
        }
      } else {
        if ((select2_data != null ? select2_data.id : void 0) != null) {
          return this.builder.showTooltip('Pilot', exportObj.pilotsById[select2_data.id]);
        }
      }
    });
    this.pilot_selector.data('select2').container.on('mouseover', (e) => {
      if (this.pilot) {
        return this.builder.showTooltip('Pilot', this.pilot, this);
      }
    });
    this.pilot_selector.data('select2').container.hide();
    if (this.builder.isQuickbuild) {
      this.wingmate_selector.on('change', (e) => {
        this.setWingmates(parseInt(this.wingmate_selector.val()));
        this.builder.current_squad.dirty = true;
        this.builder.container.trigger('xwing-backend:squadDirtinessChanged');
        return this.builder.backend_status.fadeOut('slow');
      });
      this.wingmate_selector.on('mousemove-filtered', (e) => {});
    }
    // TODO: show tooltip of wingmate
    //    select2_data = $(e.target).closest('.select2-result').data 'select2-data'
    //    if @builder.isQuickbuild
    //        @builder.showTooltip 'Quickbuild', exportObj.quickbuildsById[select2_data.id], {ship: @data?.name} if select2_data?.id?
    //    else
    //        @builder.showTooltip 'Pilot', exportObj.wingmatesById[select2_data.id] if select2_data?.id?
    //@wingmate_selector.on 'mouseover', (e) =>
    //    @builder.showTooltip 'Pilot', @wingmate, @ if @wingmate
    this.wingmate_selector.parent().hide();
    this.points_container = $(this.row.find('.points-display-container'));
    this.points_container.fadeTo(0, 0);
    this.addon_container = $(this.row.find('div.addon-container'));
    this.remove_button = $(this.row.find('button.remove-pilot'));
    this.remove_button.click((e) => {
      e.preventDefault();
      return this.row.slideUp('fast', () => {
        var ref;
        this.builder.removeShip(this);
        return (ref = this.backend_status) != null ? ref.fadeOut('slow') : void 0;
      });
    });
    this.remove_button.hide();
    this.copy_button = $(this.row.find('button.copy-pilot'));
    this.copy_button.click((e) => {
      var j, len, ref, results1, ship;
      ref = this.builder.ships;
      results1 = [];
      for (j = 0, len = ref.length; j < len; j++) {
        ship = ref[j];
        if (ship.row.hasClass("unsortable")) {
          ship.copyFrom(this);
          break;
        } else {
          results1.push(void 0);
        }
      }
      return results1;
    });
    this.copy_button.hide();
    this.checkPilotSelectorQueryModal();
    this.points_destroyed_button_span = $(this.row.find('.destroyed-type'));
    this.points_destroyed_button_span_mobile = $(this.row.find('.destroyed-type-mobile'));
    this.points_destroyed_button = $(this.row.find('button.points-destroyed'));
    this.points_destroyed_button.click((e) => {
      switch (this.destroystate) {
        case 0:
          this.destroystate++;
          this.points_destroyed_button.addClass("btn-warning");
          this.points_destroyed_button.removeClass("btn-light");
          this.points_destroyed_button_span_mobile.text(this.uitranslation("Half Damaged"));
          this.points_destroyed_button_span.html('<i class="fas fa-adjust"></i>');
          break;
        case 1:
          this.destroystate++;
          this.points_destroyed_button.addClass("btn-danger");
          this.points_destroyed_button.removeClass("btn-warning");
          this.points_destroyed_button_span_mobile.text(this.uitranslation("Fully Destroyed"));
          this.points_destroyed_button_span.html('<i class="far fa-circle"></i>');
          break;
        case 2:
          this.destroystate = 0;
          this.points_destroyed_button.addClass("btn-light");
          this.points_destroyed_button.removeClass("btn-danger");
          this.points_destroyed_button_span_mobile.text(this.uitranslation("Undamaged"));
          this.points_destroyed_button_span.html('<i class="fas fa-circle"></i>');
      }
      return this.builder.container.trigger('xwing:pointsUpdated');
    });
    return this.points_destroyed_button.hide();
  }

  teardownUI() {
    this.row.text('');
    return this.row.remove();
  }

  toString() {
    if (this.pilot != null) {
      return this.uitranslation("PilotFlyingShip", (this.pilot.display_name ? this.pilot.display_name : this.pilot.name), (this.data.display_name ? this.data.display_name : this.data.name));
    } else {
      if (this.data.display_name) {
        return this.data.display_name;
      } else {
        return this.data.name;
      }
    }
  }

  toHTML() {
    var HalfPoints, Threshold, _, action_bar, attackHTML, attack_icon, attackbHTML, attackbullHTML, attackdtHTML, attackfHTML, attacklHTML, attackrHTML, attacktHTML, chargeHTML, chassis_title, count, effective_stats, energyHTML, engagementHTML, forceHTML, html, hullIconHTML, j, l, len, m, points, recurringicon, ref, ref1, ref10, ref11, ref12, ref13, ref14, ref15, ref16, ref17, ref18, ref19, ref2, ref20, ref21, ref22, ref23, ref24, ref25, ref26, ref27, ref28, ref29, ref3, ref30, ref31, ref32, ref33, ref34, ref35, ref4, ref5, ref6, ref7, ref8, ref9, shieldHTML, shieldIconHTML, shieldRECUR, slotted_upgrades, upgrade;
    effective_stats = this.effectiveStats();
    action_bar = this.builder.formatActions(effective_stats.actions, "<div class=\"action-separator\">&nbsp;&vert;&nbsp;</div>", (ref = this.pilot.keyword) != null ? ref : []);
    attack_icon = (ref1 = this.data.attack_icon) != null ? ref1 : 'xwing-miniatures-font-frontarc';
    engagementHTML = (this.pilot.engagement != null) ? $.trim(`<span class="info-data info-skill">ENG ${this.pilot.engagement}</span>`) : '';
    attackHTML = (effective_stats.attack != null) ? $.trim(`<i class="xwing-miniatures-font header-attack ${attack_icon}"></i>
<span class="info-data info-attack">${statAndEffectiveStat((ref2 = (ref3 = this.pilot.ship_override) != null ? ref3.attack : void 0) != null ? ref2 : this.data.attack, effective_stats, 'attack')}</span>`) : '';
    if (effective_stats.attackbull != null) {
      attackbullHTML = $.trim(`<i class="xwing-miniatures-font header-attack xwing-miniatures-font-bullseyearc"></i>
<span class="info-data info-attack">${statAndEffectiveStat((ref4 = (ref5 = this.pilot.ship_override) != null ? ref5.attackbull : void 0) != null ? ref4 : this.data.attackbull, effective_stats, 'attackbull')}</span>`);
    } else {
      attackbullHTML = '';
    }
    if (effective_stats.attackb != null) {
      attackbHTML = $.trim(`<i class="xwing-miniatures-font header-attack xwing-miniatures-font-reararc"></i>
<span class="info-data info-attack">${statAndEffectiveStat((ref6 = (ref7 = this.pilot.ship_override) != null ? ref7.attackb : void 0) != null ? ref6 : this.data.attackb, effective_stats, 'attackb')}</span>`);
    } else {
      attackbHTML = '';
    }
    if (effective_stats.attackf != null) {
      attackfHTML = $.trim(`<i class="xwing-miniatures-font header-attack xwing-miniatures-font-fullfrontarc"></i>
<span class="info-data info-attack">${statAndEffectiveStat((ref8 = (ref9 = this.pilot.ship_override) != null ? ref9.attackf : void 0) != null ? ref8 : this.data.attackf, effective_stats, 'attackf')}</span>`);
    } else {
      attackfHTML = '';
    }
    if (effective_stats.attackt != null) {
      attacktHTML = $.trim(`<i class="xwing-miniatures-font header-attack xwing-miniatures-font-singleturretarc"></i>
<span class="info-data info-attack">${statAndEffectiveStat((ref10 = (ref11 = this.pilot.ship_override) != null ? ref11.attackt : void 0) != null ? ref10 : this.data.attackt, effective_stats, 'attackt')}</span>`);
    } else {
      attacktHTML = '';
    }
    if (effective_stats.attackl != null) {
      attacklHTML = $.trim(`<i class="xwing-miniatures-font header-attack xwing-miniatures-font-leftarc"></i>
<span class="info-data info-attack">${statAndEffectiveStat((ref12 = (ref13 = this.pilot.ship_override) != null ? ref13.attackl : void 0) != null ? ref12 : this.data.attackl, effective_stats, 'attackl')}</span>`);
    } else {
      attacklHTML = '';
    }
    if (effective_stats.attackr != null) {
      attackrHTML = $.trim(`<i class="xwing-miniatures-font header-attack xwing-miniatures-font-rightarc"></i>
<span class="info-data info-attack">${statAndEffectiveStat((ref14 = (ref15 = this.pilot.ship_override) != null ? ref15.attackr : void 0) != null ? ref14 : this.data.attackr, effective_stats, 'attackr')}</span>`);
    } else {
      attackrHTML = '';
    }
    if (effective_stats.attackdt != null) {
      attackdtHTML = $.trim(`<i class="xwing-miniatures-font header-attack xwing-miniatures-font-doubleturretarc"></i>
<span class="info-data info-attack">${statAndEffectiveStat((ref16 = (ref17 = this.pilot.ship_override) != null ? ref17.attackdt : void 0) != null ? ref16 : this.data.attackdt, effective_stats, 'attackdt')}</span>`);
    } else {
      attackdtHTML = '';
    }
    recurringicon = '';
    if (this.data.energyrecurr != null) {
      count = 0;
      while (count < this.data.energyrecurr) {
        recurringicon += '<sup><i class="fas fa-caret-up"></i></sup>';
        ++count;
      }
    }
    energyHTML = (((ref18 = this.pilot.ship_override) != null ? ref18.energy : void 0) != null) || (this.data.energy != null) ? $.trim(`<i class="xwing-miniatures-font header-energy xwing-miniatures-font-energy"></i>
<span class="info-data info-energy">${statAndEffectiveStat((ref19 = (ref20 = this.pilot.ship_override) != null ? ref20.energy : void 0) != null ? ref19 : this.data.energy, effective_stats, 'energy')}${recurringicon}</span>`) : '';
    if (effective_stats.force != null) {
      recurringicon = '';
      if (effective_stats.forcerecurring != null) {
        count = 0;
        while (count < effective_stats.forcerecurring) {
          recurringicon += '<sup><i class="fas fa-caret-up"></i></sup>';
          ++count;
        }
      } else {
        recurringicon += '<sup><i class="fas fa-caret-up"></i></sup>';
      }
    }
    forceHTML = ((effective_stats.force != null) && effective_stats.force > 0) ? $.trim(`<i class="xwing-miniatures-font header-force xwing-miniatures-font-forcecharge"></i>
<span class="info-data info-force">${statAndEffectiveStat((ref21 = (ref22 = (ref23 = this.pilot.ship_override) != null ? ref23.force : void 0) != null ? ref22 : this.pilot.force) != null ? ref21 : 0, effective_stats, 'force')}${recurringicon}</span>`) : '';
    if (this.pilot.charge != null) {
      recurringicon = '';
      if (this.pilot.recurring != null) {
        if (this.pilot.recurring > 0) {
          count = 0;
          while (count < this.pilot.recurring) {
            recurringicon += '<sup><i class="fas fa-caret-up"></i></sup>';
            ++count;
          }
        } else {
          count = this.pilot.recurring;
          while (count < 0) {
            recurringicon += '<sub><i class="fas fa-caret-down"></i></sub>';
            ++count;
          }
        }
      }
      chargeHTML = $.trim(`<i class="xwing-miniatures-font header-charge xwing-miniatures-font-charge"></i><span class="info-data info-charge">${statAndEffectiveStat((ref24 = (ref25 = this.pilot.ship_override) != null ? ref25.charge : void 0) != null ? ref24 : this.pilot.charge, effective_stats, 'charge')}${recurringicon}</span>`);
    } else {
      chargeHTML = '';
    }
    shieldRECUR = '';
    if (this.data.shieldrecurr != null) {
      count = 0;
      while (count < this.data.shieldrecurr) {
        shieldRECUR += `<sup><i class="fas fa-caret-up"></i></sup>`;
        ++count;
      }
    }
    shieldIconHTML = '';
    if (effective_stats.shields) {
      for (_ = j = ref26 = effective_stats.shields; j >= 2; _ = j += -1) {
        shieldIconHTML += `<i class="xwing-miniatures-font header-shield xwing-miniatures-font-shield expanded-hull-or-shield"></i>`;
      }
      shieldIconHTML += `<i class="xwing-miniatures-font header-shield xwing-miniatures-font-shield"></i>`;
    }
    hullIconHTML = '';
    if (effective_stats.hull) {
      for (_ = l = ref27 = effective_stats.hull; l >= 2; _ = l += -1) {
        hullIconHTML += `<i class="xwing-miniatures-font header-hull xwing-miniatures-font-hull expanded-hull-or-shield"></i>`;
      }
      hullIconHTML += `<i class="xwing-miniatures-font header-hull xwing-miniatures-font-hull"></i>`;
    }
    shieldHTML = ((effective_stats.shields != null) && effective_stats.shields > 0) ? $.trim(`<span class="info-data info-shields">${statAndEffectiveStat((ref28 = (ref29 = this.pilot.ship_override) != null ? ref29.shields : void 0) != null ? ref28 : this.data.shields, effective_stats, 'shields')}${shieldRECUR}</span>`) : '';
    html = $.trim(`<div class="fancy-pilot-header">
    <div class="pilot-header-text">${this.pilot.display_name ? this.pilot.display_name : this.pilot.name} <i class="xwing-miniatures-ship xwing-miniatures-ship-${this.data.name.canonicalize()}"></i><span class="fancy-ship-type"> ${this.data.display_name ? this.data.display_name : this.data.name}</span></div>
    <div class="mask">
        <div class="outer-circle">
            <div class="inner-circle pilot-points">${this.quickbuildId !== -1 ? (this.primary ? this.getPoints() : '*') : ((this.builder.isXwa && (this.pilot.pointsxwa != null)) ? this.pilot.pointsxwa : this.pilot.points)}</div>
        </div>
    </div>
</div>
<div class="fancy-pilot-stats">
    <div class="pilot-stats-content">
        <span class="info-data info-skill">INI ${statAndEffectiveStat(this.pilot.skill, effective_stats, 'skill')}</span>
        ${engagementHTML}
        ${attackbullHTML}
        ${attackHTML}
        ${attackbHTML}
        ${attackfHTML}
        ${attacktHTML}
        ${attacklHTML}
        ${attackrHTML}
        ${attackdtHTML}
        <i class="xwing-miniatures-font header-agility xwing-miniatures-font-agility"></i>
        <span class="info-data info-agility">${statAndEffectiveStat((ref30 = (ref31 = this.pilot.ship_override) != null ? ref31.agility : void 0) != null ? ref30 : this.data.agility, effective_stats, 'agility')}</span>                    
        ${hullIconHTML}
        <span class="info-data info-hull">${statAndEffectiveStat((ref32 = (ref33 = this.pilot.ship_override) != null ? ref33.hull : void 0) != null ? ref32 : this.data.hull, effective_stats, 'hull')}</span>
        ${shieldIconHTML}
        ${shieldHTML}
        ${energyHTML}
        ${forceHTML}
        ${chargeHTML}
        <br />
        <div class="action-bar">
            ${action_bar}
        </div>
    </div>
</div>`);
    if (this.pilot.text) {
      html += $.trim(`<div class="fancy-pilot-text">${this.pilot.text}</div>`);
    }
    if (((effective_stats != null ? effective_stats.chassis : void 0) != null) && (effective_stats.chassis !== "")) {
      chassis_title = effective_stats.chassis;
    } else if (this.data.chassis != null) {
      chassis_title = this.data.chassis;
    } else {
      chassis_title = "";
    }
    if (chassis_title !== "") {
      html += $.trim(`<div class="fancy-pilot-chassis"><strong>${(ref34 = (ref35 = exportObj.chassis[chassis_title]) != null ? ref35.display_name : void 0) != null ? ref34 : chassis_title}:</strong> ${exportObj.chassis[chassis_title].text}</div>`);
    }
    slotted_upgrades = (function() {
      var len, m, ref36, results1;
      ref36 = this.upgrades;
      results1 = [];
      for (m = 0, len = ref36.length; m < len; m++) {
        upgrade = ref36[m];
        if (upgrade.data != null) {
          results1.push(upgrade);
        }
      }
      return results1;
    }).call(this);
    if (slotted_upgrades.length > 0) {
      html += $.trim(`<div class="fancy-upgrade-container">`);
      for (m = 0, len = slotted_upgrades.length; m < len; m++) {
        upgrade = slotted_upgrades[m];
        points = upgrade.getPoints();
        html += upgrade.toHTML(points);
      }
      html += $.trim(`</div>`);
    }
    HalfPoints = Math.floor(this.getPoints() / 2);
    Threshold = Math.floor((effective_stats['hull'] + effective_stats['shields']) / 2);
    html += $.trim(`<div class="ship-points-total">
    <strong>${this.uitranslation("Ship Cost")}: ${this.getPoints()}, ${this.uitranslation("Loadout")}: (${this.upgrade_points_total}${(this.builder.isXwa && (this.pilot.loadoutxwa != null)) ? `/${this.pilot.loadoutxwa}` : (this.pilot.loadout != null ? `/${this.pilot.loadout}` : "")}), ${this.uitranslation("Half Points")}: ${HalfPoints}, ${this.uitranslation("Damage Threshold")}: ${Threshold}</strong> 
</div>`);
    return `<div class="fancy-ship">${html}</div>`;
  }

  toTableRow() {
    var halfPoints, j, len, points, slotted_upgrades, table_html, threshold, upgrade;
    table_html = $.trim(`<tr class="simple-pilot">
    <td class="name">${this.pilot.display_name ? this.pilot.display_name : this.pilot.name} &mdash; ${this.data.display_name ? this.data.display_name : this.data.name}</td>
    <td class="points">${this.quickbuildId !== -1 ? (this.primary ? exportObj.quickbuildsById[this.quickbuildId].threat : 0) : ((this.builder.isXwa && (this.pilot.pointsxwa != null)) ? this.pilot.pointsxwa : this.pilot.points)}</td>
</tr>`);
    slotted_upgrades = (function() {
      var j, len, ref, results1;
      ref = this.upgrades;
      results1 = [];
      for (j = 0, len = ref.length; j < len; j++) {
        upgrade = ref[j];
        if (upgrade.data != null) {
          results1.push(upgrade);
        }
      }
      return results1;
    }).call(this);
    if (slotted_upgrades.length > 0) {
      for (j = 0, len = slotted_upgrades.length; j < len; j++) {
        upgrade = slotted_upgrades[j];
        points = upgrade.getPoints();
        table_html += upgrade.toTableRow(points);
      }
    }
    table_html += `<tr class="simple-ship-total"><td colspan="2">${this.uitranslation("Ship Cost")}: ${this.getPoints()}</td></tr>`;
    halfPoints = Math.floor(this.getPoints() / 2);
    threshold = Math.floor((this.effectiveStats()['hull'] + this.effectiveStats()['shields']) / 2);
    table_html += `<tr class="simple-ship-half-points"><td colspan="2">${this.uitranslation("Loadout")}: (${this.upgrade_points_total}${(this.builder.isXwa && (this.pilot.loadoutxwa != null)) ? `/${this.pilot.loadoutxwa}` : (this.pilot.loadout != null ? `/${this.pilot.loadout}` : "")}) ${this.uitranslation("Half Points")}: ${halfPoints} ${this.uitranslation("Damage Threshold")}: ${threshold}</td></tr>`;
    table_html += '<tr><td>&nbsp;</td><td></td></tr>';
    return table_html;
  }

  toSimpleCopy() {
    var halfPoints, j, len, points, simplecopy, simplecopy_upgrades, slotted_upgrades, threshold, upgrade, upgrade_simplecopy;
    simplecopy = `${this.pilot.display_name} – ${this.data.display_name} (${this.quickbuildId !== -1 ? (this.primary ? exportObj.quickbuildsById[this.quickbuildId].threat : 0) : ((this.builder.isXwa && (this.pilot.pointsxwa != null)) ? this.pilot.pointsxwa : this.pilot.points)})    \n`;
    slotted_upgrades = (function() {
      var j, len, ref, results1;
      ref = this.upgrades;
      results1 = [];
      for (j = 0, len = ref.length; j < len; j++) {
        upgrade = ref[j];
        if (upgrade.data != null) {
          results1.push(upgrade);
        }
      }
      return results1;
    }).call(this);
    if (slotted_upgrades.length > 0) {
      simplecopy += "    ";
      simplecopy_upgrades = [];
      for (j = 0, len = slotted_upgrades.length; j < len; j++) {
        upgrade = slotted_upgrades[j];
        points = upgrade.getPoints();
        upgrade_simplecopy = upgrade.toSimpleCopy(points);
        if (upgrade_simplecopy != null) {
          simplecopy_upgrades.push(upgrade_simplecopy);
        }
      }
      simplecopy += simplecopy_upgrades.join("    ");
      simplecopy += `    \n`;
    }
    halfPoints = Math.floor(this.getPoints() / 2);
    threshold = Math.floor((this.effectiveStats()['hull'] + this.effectiveStats()['shields']) / 2);
    simplecopy += `${this.uitranslation("Ship Cost")}: ${this.getPoints()}  ${this.uitranslation("Loadout")}: (${this.upgrade_points_total}${(this.builder.isXwa && (this.pilot.loadoutxwa != null)) ? `/${this.pilot.loadoutxwa}` : (this.pilot.loadout != null ? `/${this.pilot.loadout}` : "")})  ${this.uitranslation("Half Points")}: ${halfPoints}  ${this.uitranslation("Damage Threshold")}: ${threshold}    \n    \n`;
    return simplecopy;
  }

  toRedditText() {
    var halfPoints, j, len, points, reddit, reddit_upgrades, slotted_upgrades, threshold, upgrade, upgrade_reddit;
    reddit = `**${this.pilot.name} (${this.quickbuildId !== -1 ? (this.primary ? exportObj.quickbuildsById[this.quickbuildId].threat : 0) : ((this.builder.isXwa && (this.pilot.pointsxwa != null)) ? this.pilot.pointsxwa : this.pilot.points)})**    \n`;
    slotted_upgrades = (function() {
      var j, len, ref, results1;
      ref = this.upgrades;
      results1 = [];
      for (j = 0, len = ref.length; j < len; j++) {
        upgrade = ref[j];
        if (upgrade.data != null) {
          results1.push(upgrade);
        }
      }
      return results1;
    }).call(this);
    if (slotted_upgrades.length > 0) {
      halfPoints = Math.floor(this.getPoints() / 2);
      threshold = Math.floor((this.effectiveStats()['hull'] + this.effectiveStats()['shields']) / 2);
      reddit += "    ";
      reddit_upgrades = [];
      for (j = 0, len = slotted_upgrades.length; j < len; j++) {
        upgrade = slotted_upgrades[j];
        points = upgrade.getPoints();
        upgrade_reddit = upgrade.toRedditText(points);
        if (upgrade_reddit != null) {
          reddit_upgrades.push(upgrade_reddit);
        }
      }
      reddit += reddit_upgrades.join("    ");
      reddit += `&nbsp;*${this.uitranslation("Ship Cost")}: ${this.getPoints()}  ${this.uitranslation("Loadout")}: (${this.upgrade_points_total}${(this.builder.isXwa && (this.pilot.loadoutxwa != null)) ? `/${this.pilot.loadoutxwa}` : (this.pilot.loadout != null ? `/${this.pilot.loadout}` : "")})  ${this.uitranslation("Half Points")}: ${halfPoints}  ${this.uitranslation("Damage Threshold")}: ${threshold}*    \n`;
    }
    return reddit;
  }

  toTTSText() {
    var j, len, slotted_upgrades, tts, upgrade, upgrade_tts;
    tts = `${exportObj.toTTS(this.pilot.name)}`;
    slotted_upgrades = (function() {
      var j, len, ref, results1;
      ref = this.upgrades;
      results1 = [];
      for (j = 0, len = ref.length; j < len; j++) {
        upgrade = ref[j];
        if (upgrade.data != null) {
          results1.push(upgrade);
        }
      }
      return results1;
    }).call(this);
    if (slotted_upgrades.length > 0 && (this.pilot.upgrades == null)) {
      for (j = 0, len = slotted_upgrades.length; j < len; j++) {
        upgrade = slotted_upgrades[j];
        upgrade_tts = upgrade.toTTSText();
        if (upgrade_tts != null) {
          tts += " + " + upgrade_tts;
        }
      }
    }
    return tts += " / ";
  }

  toSerialized() {
    var i, upgrade, upgrades;
    // PILOT_ID:UPGRADEID1,UPGRADEID2:CONFERREDADDONTYPE1.CONFERREDADDONID1,CONFERREDADDONTYPE2.CONFERREDADDONID2
    if (this.builder.isQuickbuild) {
      if ((this.wingmates == null) || this.wingmates.length === 0) {
        return `${this.quickbuildId}X`;
      } else {
        return `${this.quickbuildId}X${this.wingmates.length}`;
      }
    } else {
      upgrades = `${(function() {
        var j, len, ref, ref1, ref2, results1;
        ref = this.upgrades;
        results1 = [];
        for (i = j = 0, len = ref.length; j < len; i = ++j) {
          upgrade = ref[i];
          results1.push((ref1 = upgrade != null ? (ref2 = upgrade.data) != null ? ref2.id : void 0 : void 0) != null ? ref1 : "");
        }
        return results1;
      }).call(this)}`.replace(/,/g, "W");
      return [this.pilot.id, upgrades].join('X');
    }
  }

  async fromSerialized(version, serialized) {
    var _, conferredaddon_pairs, everythingadded, i, j, l, len, len1, m, o, pilot_id, pilot_splitter, ref, ref1, ref2, ref3, upgrade, upgrade_id, upgrade_ids, upgrade_selection, upgrade_splitter;
    // adds a ship from the given serialized data to the squad. 
    // returns true, if all upgrades have been added successfully, false otherwise
    // returning false does not necessary mean nothing has been added, but some stuff might have been dropped (e.g. 0-0-0 if vader is not yet in the squad)
    everythingadded = true;
    switch (version) {
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
      case 8:
        // v 1-3 are 1st Ed
        // v 4-8 are 2nd Ed 
        // v 9+ are 2.5 Ed 
        console.log("Incorrect Version!");
        this.old_version_container.toggleClass('d-none', false);
        break;
      case 9:
        pilot_splitter = 'X';
        upgrade_splitter = 'W';
        [pilot_id, upgrade_ids, conferredaddon_pairs] = serialized.split(pilot_splitter);
        upgrade_ids = upgrade_ids.split(upgrade_splitter);
        // set the pilot
        await this.setPilotById(parseInt(pilot_id), true);
        if (!this.validate) {
          // make sure the pilot is valid 
          return false;
        }
        if (!this.builder.isQuickbuild) {
// try adding each upgrade a few times, as the required slots might be added in by titles etc and are not yet available on the first try
// iterate over upgrades to be added, and remove all that have been successfully added
          for (_ = j = 1; j < 3; _ = ++j) {
            upgradeloop: //;
            for (i = l = ref = upgrade_ids.length - 1; (ref <= -1 ? l < -1 : l > -1); i = ref <= -1 ? ++l : --l) {
              upgrade_id = upgrade_ids[i];
              upgrade = exportObj.upgradesById[upgrade_id];
              if (upgrade == null) {
                upgrade_ids.splice(i, 1); // Remove unknown or empty ID
                if (upgrade_id !== "") {
                  console.log("Unknown upgrade id " + upgrade_id + " could not be added. Please report that error");
                  everythingadded = false;
                }
                continue;
              }
              ref1 = this.upgrades;
              for (m = 0, len = ref1.length; m < len; m++) {
                upgrade_selection = ref1[m];
                if ((upgrade_selection != null ? (ref2 = upgrade_selection.data) != null ? ref2.name : void 0 : void 0) === upgrade.name) {
                  // for some reason the correct upgrade already was equipped (e.g. an earlier ship alread had a standardized that was added on creation here)
                  upgrade_ids.splice(i, 1); // was already added successfully, remove from list
                  continue upgradeloop;
                }
              }
              ref3 = this.upgrades;
              for (o = 0, len1 = ref3.length; o < len1; o++) {
                upgrade_selection = ref3[o];
                if (exportObj.slotsMatching(upgrade.slot, upgrade_selection.slot) && !upgrade_selection.isOccupied()) {
                  await upgrade_selection.setById(upgrade_id);
                  if (upgrade_selection.lastSetValid) {
                    upgrade_ids.splice(i, 1); // added successfully, remove from list
                  }
                  break;
                }
              }
            }
          }
        } else {
          
          // we are in quickbuild. Number of wingmates might be provided as upgrade ID of a quickbuild
          if (upgrade_ids.length > 0 && this.wingmates.length > 0) { // check if we are actually a wingleader
            this.setWingmates(upgrade_ids[0]);
          }
        }
        everythingadded &= upgrade_ids.length === 0;
    }
    this.updateSelections();
    return everythingadded;
  }

  effectiveStats() {
    var j, l, len, len1, m, maneuvers_override, new_stats, ref, ref1, ref10, ref11, ref12, ref13, ref14, ref15, ref16, ref17, ref18, ref19, ref2, ref20, ref21, ref22, ref23, ref24, ref25, ref26, ref27, ref28, ref29, ref3, ref30, ref31, ref32, ref33, ref34, ref35, ref36, ref37, ref38, ref39, ref4, ref40, ref41, ref42, ref43, ref44, ref5, ref6, ref7, ref8, ref9, s, statentry, stats, upgrade;
    stats = {
      attack: (ref = (ref1 = this.pilot.ship_override) != null ? ref1.attack : void 0) != null ? ref : this.data.attack,
      attackf: (ref2 = (ref3 = this.pilot.ship_override) != null ? ref3.attackf : void 0) != null ? ref2 : this.data.attackf,
      attackbull: (ref4 = (ref5 = this.pilot.ship_override) != null ? ref5.attackbull : void 0) != null ? ref4 : this.data.attackbull,
      attackb: (ref6 = (ref7 = this.pilot.ship_override) != null ? ref7.attackb : void 0) != null ? ref6 : this.data.attackb,
      attackt: (ref8 = (ref9 = this.pilot.ship_override) != null ? ref9.attackt : void 0) != null ? ref8 : this.data.attackt,
      attackl: (ref10 = (ref11 = this.pilot.ship_override) != null ? ref11.attackl : void 0) != null ? ref10 : this.data.attackl,
      attackr: (ref12 = (ref13 = this.pilot.ship_override) != null ? ref13.attackr : void 0) != null ? ref12 : this.data.attackr,
      attackdt: (ref14 = (ref15 = this.pilot.ship_override) != null ? ref15.attackdt : void 0) != null ? ref14 : this.data.attackdt,
      energy: (ref16 = (ref17 = this.pilot.ship_override) != null ? ref17.energy : void 0) != null ? ref16 : this.data.energy,
      agility: (ref18 = (ref19 = this.pilot.ship_override) != null ? ref19.agility : void 0) != null ? ref18 : this.data.agility,
      hull: (ref20 = (ref21 = this.pilot.ship_override) != null ? ref21.hull : void 0) != null ? ref20 : this.data.hull,
      shields: (ref22 = (ref23 = this.pilot.ship_override) != null ? ref23.shields : void 0) != null ? ref22 : this.data.shields,
      force: (ref24 = (ref25 = (ref26 = this.pilot.ship_override) != null ? ref26.force : void 0) != null ? ref25 : this.pilot.force) != null ? ref24 : 0,
      forcerecurring: (ref27 = this.pilot.forcerecurring) != null ? ref27 : 1,
      charge: (ref28 = (ref29 = this.pilot.ship_override) != null ? ref29.charge : void 0) != null ? ref28 : this.pilot.charge,
      actions: ((ref30 = (ref31 = this.pilot.ship_override) != null ? ref31.actions : void 0) != null ? ref30 : this.data.actions).slice(0),
      chassis: (ref32 = (ref33 = this.pilot.chassis) != null ? ref33 : this.data.chassis) != null ? ref32 : "",
      points: (ref34 = this.pilot.points) != null ? ref34 : 0,
      loadout: (ref35 = this.pilot.loadout) != null ? ref35 : 0,
      skill: (ref36 = this.pilot.skill) != null ? ref36 : 0
    };
    // override when in XWA mode
    if (this.builder.isXwa) {
      if (this.pilot.pointsxwa != null) {
        stats.points = this.pilot.pointsxwa;
      }
      if (this.pilot.loadoutxwa != null) {
        stats.loadout = this.pilot.loadoutxwa;
      }
    }
    // need a deep copy of maneuvers array
    maneuvers_override = (ref37 = (ref38 = this.pilot.ship_override) != null ? ref38.maneuvers : void 0) != null ? ref37 : this.data.maneuvers;
    stats.maneuvers = [];
    for (s = j = 0, ref39 = (maneuvers_override != null ? maneuvers_override : []).length; (0 <= ref39 ? j < ref39 : j > ref39); s = 0 <= ref39 ? ++j : --j) {
      stats.maneuvers[s] = maneuvers_override[s].slice(0);
    }
    // Droid conversion of Focus to Calculate
    if ((this.pilot.keyword != null) && (indexOf.call(this.pilot.keyword, "Droid") >= 0) && (stats.actions != null)) {
      new_stats = [];
      ref40 = stats.actions;
      for (l = 0, len = ref40.length; l < len; l++) {
        statentry = ref40[l];
        new_stats.push(statentry.replace("Focus", "Calculate"));
      }
      stats.actions = new_stats;
    }
    ref41 = this.upgrades;
    for (m = 0, len1 = ref41.length; m < len1; m++) {
      upgrade = ref41[m];
      if ((upgrade != null ? (ref42 = upgrade.data) != null ? ref42.chassis : void 0 : void 0) != null) {
        stats.chassis = upgrade.data.chassis;
      }
      if ((upgrade != null ? (ref43 = upgrade.data) != null ? ref43.modifier_func : void 0 : void 0) != null) {
        upgrade.data.modifier_func(stats);
      }
    }
    if (((ref44 = this.pilot) != null ? ref44.modifier_func : void 0) != null) {
      this.pilot.modifier_func(stats);
    }
    if ((exportObj.chassis[stats.chassis] != null) && (exportObj.chassis[stats.chassis].modifier_func != null)) {
      exportObj.chassis[stats.chassis].modifier_func(stats);
    }
    return stats;
  }

  async validate() {
    var addCommand, equipped_upgrades, func, i, j, l, len, len1, len2, len3, m, max_checks, meets_restrictions, o, pilot_func, pilot_upgrades_check, q, ref, ref1, ref10, ref11, ref12, ref13, ref14, ref15, ref16, ref17, ref18, ref19, ref2, ref20, ref21, ref3, ref4, ref5, ref6, ref7, ref8, ref9, restrictions, unchanged, upgrade, upgradeslot, valid, y;
    // while we load a squad we defer the validation to after everything is loaded, as there might be a lot of mutual dependencies.
    if (this.builder.isCurrentlyLoadingSquad) {
      return true;
    }
    // Remove addons that violate their validation functions (if any) one by one until everything checks out
    // Returns true, if nothing has been changed, and false otherwise
    // check if we are an empty selection, which is always valid
    if (this.pilot == null) {
      return true;
    }
    unchanged = true;
    max_checks = 8; // that's a lot of addons
    if (this.builder.isEpic) { //Command Epic adding
      if ((this.pilot.slots != null) && !(indexOf.call(this.pilot.slots, "Command") >= 0)) {
        addCommand = true;
        ref = this.upgrades;
        for (j = 0, len = ref.length; j < len; j++) {
          upgrade = ref[j];
          if (("Command" === upgrade.slot) && (this === upgrade.ship)) {
            addCommand = false;
          }
        }
        if (addCommand === true) {
          this.upgrades.push(new exportObj.Upgrade({
            ship: this,
            container: this.addon_container,
            slot: "Command"
          }));
        }
      }
    } else if (!this.builder.isQuickbuild) { //cleanup Command upgrades
      for (i = l = ref1 = this.upgrades.length - 1; (ref1 <= -1 ? l < -1 : l > -1); i = ref1 <= -1 ? ++l : --l) {
        upgrade = this.upgrades[i];
        if (upgrade.slot === "Command") {
          upgrade.destroy($.noop);
          this.upgrades.splice(i, 1);
        }
      }
    }
    for (i = m = 0, ref2 = max_checks; (0 <= ref2 ? m < ref2 : m > ref2); i = 0 <= ref2 ? ++m : --m) {
      valid = true;
      pilot_func = (ref3 = (ref4 = (ref5 = this.pilot) != null ? ref5.validation_func : void 0) != null ? ref4 : (ref6 = this.pilot) != null ? ref6.restriction_func : void 0) != null ? ref3 : void 0;
      pilot_upgrades_check = this.pilot.upgrades != null;
      if (((pilot_func != null) && !pilot_func(this, this.pilot)) || !(this.builder.isItemAvailable(this.pilot, true))) {
        // we go ahead and happily remove ourself. Of course, when calling a method like validate on an object, you have to expect that it will dissappear, right?
        this.builder.removeShip(this);
        return false; // no need to check anything further, as we do not exist anymore 
      }
      // everything is limited in X-Wing 2.0, so we need to check if any upgrade is equipped more than once
      equipped_upgrades = [];
      this.upgrade_points_total = 0;
      ref7 = this.upgrades;
      for (o = 0, len1 = ref7.length; o < len1; o++) {
        upgrade = ref7[o];
        meets_restrictions = true;
        if (!pilot_upgrades_check) {
          func = (ref8 = upgrade != null ? (ref9 = upgrade.data) != null ? ref9.validation_func : void 0 : void 0) != null ? ref8 : void 0;
          if (func != null) {
            meets_restrictions = meets_restrictions && (upgrade != null ? (ref10 = upgrade.data) != null ? ref10.validation_func(this, upgrade) : void 0 : void 0);
          }
          // moved occupied slots off of validation func
          if (this.builder.isXwa && ((upgrade != null ? (ref11 = upgrade.data) != null ? ref11.also_occupies_upgrades_xwa : void 0 : void 0) != null)) {
            ref12 = upgrade.data.also_occupies_upgrades_xwa;
            for (q = 0, len2 = ref12.length; q < len2; q++) {
              upgradeslot = ref12[q];
              meets_restrictions = meets_restrictions && upgrade.occupiesAnUpgradeSlot(upgradeslot);
            }
          } else {
            if ((upgrade != null ? (ref13 = upgrade.data) != null ? ref13.also_occupies_upgrades : void 0 : void 0) != null) {
              ref14 = upgrade.data.also_occupies_upgrades;
              for (y = 0, len3 = ref14.length; y < len3; y++) {
                upgradeslot = ref14[y];
                meets_restrictions = meets_restrictions && upgrade.occupiesAnUpgradeSlot(upgradeslot);
              }
            }
          }
          restrictions = ((upgrade != null ? (ref15 = upgrade.data) != null ? ref15.restrictionsxwa : void 0 : void 0) != null) && this.builder.isXwa ? upgrade != null ? (ref16 = upgrade.data) != null ? ref16.restrictionsxwa : void 0 : void 0 : (ref17 = upgrade != null ? (ref18 = upgrade.data) != null ? ref18.restrictions : void 0 : void 0) != null ? ref17 : void 0;
          // always perform this check, even if no special restrictions for this upgrade exists, to check for allowed points
          meets_restrictions = meets_restrictions && this.restriction_check(restrictions, upgrade, upgrade.getPoints(), this.upgrade_points_total);
        }
        // ignore those checks if this is a pilot with upgrades or quickbuild
        if ((!meets_restrictions || (((upgrade != null ? upgrade.data : void 0) != null) && ((ref19 = upgrade.data, indexOf.call(equipped_upgrades, ref19) >= 0) || ((upgrade.data.faction != null) && !this.builder.isOurFaction(upgrade.data.faction, this.pilot.faction)) || !this.builder.isItemAvailable(upgrade.data)))) && !pilot_upgrades_check && !this.builder.isQuickbuild) {
          console.log(`Invalid upgrade: ${upgrade != null ? (ref20 = upgrade.data) != null ? ref20.name : void 0 : void 0} on pilot ${(ref21 = this.pilot) != null ? ref21.name : void 0}`);
          await upgrade.setById(null);
          valid = false;
          unchanged = false;
          break;
        }
        if (((upgrade != null ? upgrade.data : void 0) != null) && upgrade.data) {
          equipped_upgrades.push(upgrade != null ? upgrade.data : void 0);
        }
        this.upgrade_points_total += upgrade.getPoints();
      }
      if (valid) {
        break;
      }
    }
    this.updateSelections();
    return unchanged;
  }

  checkUnreleasedContent() {
    var j, len, ref, upgrade;
    if ((this.pilot != null) && !exportObj.isReleased(this.pilot)) {
      //console.log "#{@pilot.name} is unreleased"
      return true;
    }
    ref = this.upgrades;
    for (j = 0, len = ref.length; j < len; j++) {
      upgrade = ref[j];
      if (((upgrade != null ? upgrade.data : void 0) != null) && (!exportObj.isReleased(upgrade.data)) && (upgrade.data.standard == null)) {
        //console.log "#{upgrade.data.id} is unreleased"
        return true;
      }
    }
    return false;
  }

  hasAnotherUnoccupiedSlotLike(upgrade_obj, upgradeslot) {
    var j, len, ref, upgrade;
    ref = this.upgrades;
    for (j = 0, len = ref.length; j < len; j++) {
      upgrade = ref[j];
      if (upgrade === upgrade_obj || !exportObj.slotsMatching(upgrade.slot, upgradeslot) || upgrade.slot === "HardpointShip" || upgrade.slot === "VersatileShip") {
        continue;
      }
      if (!upgrade.isOccupied()) {
        return true;
      }
    }
    return false;
  }

  hasFilledSlotLike(upgrade_obj, upgradeslot) {
    var j, len, ref, upgrade;
    ref = this.upgrades;
    for (j = 0, len = ref.length; j < len; j++) {
      upgrade = ref[j];
      if (upgrade === upgrade_obj || !exportObj.slotsMatching(upgrade.slot, upgradeslot)) {
        continue;
      }
      if (upgrade.isOccupied()) {
        return true;
      }
    }
    return false;
  }

  restriction_check(restrictions, upgrade_obj, points = 0, current_upgrade_points = 0, upgrade_data = void 0) {
    var action, b, base, check, effective_stats, j, l, len, len1, len2, loadout, m, r, ref, ref1, ref2, w;
    effective_stats = this.effectiveStats();
    if (this.pilot.loadout != null) {
      loadout = effective_stats.loadout;
      if (points + current_upgrade_points > loadout) {
        return false;
      }
    }
    if (restrictions != null) {
      for (j = 0, len = restrictions.length; j < len; j++) {
        r = restrictions[j];
        switch (r[0]) {
          case "FactionOrUnique":
            if (this.pilot.faction !== r[2] && !this.checkListForUnique(r[1].toLowerCase().replace(/[^0-9a-z]/gi, '').replace(/\s+/g, '-'))) {
              return false;
            }
            break;
          case "Base":
            check = false;
            for (l = 0, len1 = r.length; l < len1; l++) {
              b = r[l];
              if (b === "Base") {
                continue;
              }
              if (b.startsWith("Non-")) {
                base = b.substring(4);
              } else {
                base = b; // check if its an non- case then remove the non-
              }
              switch (base) {
                case "Small":
                  if (this.data.base == null) {
                    check = true;
                  }
                  break;
                case "Standard":
                  if (!((this.data.base != null) && this.data.base === "Huge")) {
                    check = true;
                  }
                  break;
                default:
                  if ((this.data.base != null) && this.data.base === base) {
                    check = true;
                  }
              }
              if (b !== base) {
                check = !check; // invert results for non- result
              }
              if (check === true) {
                break;
              }
            }
            if (check === false) {
              return false;
            }
            break;
          case "Action":
            if (r[1].startsWith("W-")) {
              w = r[1].substring(2);
              if (indexOf.call(effective_stats.actions, w) < 0) {
                return false;
              }
            } else {
              check = false;
              ref = effective_stats.actions;
              for (m = 0, len2 = ref.length; m < len2; m++) {
                action = ref[m];
                if (action.includes(r[1]) && !action.includes(">")) {
                  check = true;
                }
              }
              if (check === false) {
                return false;
              }
            }
            break;
          case "Keyword":
            if (!(this.checkKeyword(r[1]))) {
              return false;
            }
            break;
          case "Equipped":
            if (!(this.doesSlotExist(r[1]) && this.hasFilledSlotLike(upgrade_obj, r[1]))) {
              return false;
            }
            break;
          case "Slot":
            if ((!this.hasAnotherUnoccupiedSlotLike(upgrade_obj, r[1]) && !(upgrade_obj != null ? typeof upgrade_obj.occupiesAnUpgradeSlot === "function" ? upgrade_obj.occupiesAnUpgradeSlot(r[1]) : void 0 : void 0)) || upgrade_obj.slot === "HardpointShip" || upgrade_obj.slot === "VersatileShip") {
              return false;
            }
            break;
          case "AttackArc":
            if (this.data.attackb == null) {
              return false;
            }
            break;
          case "ShieldsGreaterThan":
            if (!(this.data.shields > r[1])) {
              return false;
            }
            break;
          case "EnergyGreatterThan":
            if (!(effective_stats.energy > r[1])) {
              return false;
            }
            break;
          case "InitiativeGreaterThan":
            if (!(this.pilot.skill > r[1])) {
              return false;
            }
            break;
          case "InitiativeLessThan":
            if (!(this.pilot.skill < r[1])) {
              return false;
            }
            break;
          case "HasForce":
            if ((this.pilot.force != null) !== r[1]) {
              false;
            }
            break;
          case "AgilityEquals":
            if (!(effective_stats.agility === r[1])) {
              return false;
            }
            break;
          case "isUnique":
            if (r[1] !== ((this.pilot.unique != null) || (this.pilot.max_per_squad != null))) {
              return false;
            }
            break;
          case "Format":
            switch (r[1]) {
              case "Epic":
                if (!(ref1 = this.data.name, indexOf.call(exportObj.epicExclusionsList, ref1) >= 0)) {
                  return false;
                }
                break;
              case "Standard":
                if (ref2 = this.data.name, indexOf.call(exportObj.epicExclusionsList, ref2) >= 0) {
                  return false;
                }
            }
        }
      }
    }
    return true;
  }

  standardized_check(upgrade_data) {
    var checkstandard, j, l, len, len1, ref, ref1, ref2, restrictions, ship, slotfree, upgrade;
    // condition checks
    checkstandard = false;
    if (this.builder.isXwa) {
      if (upgrade_data.standardizedxwa != null) {
        checkstandard = upgrade_data.standardizedxwa;
      }
    } else {
      if (upgrade_data.standardized != null) {
        checkstandard = true;
      }
    }
    if (checkstandard) {
      ref = this.builder.ships;
      for (j = 0, len = ref.length; j < len; j++) {
        ship = ref[j];
        if (((ship != null ? ship.data : void 0) != null) && ship.data.name === this.data.name) {
          if (this.builder.isXwa) {
            if (upgrade_data.restrictionsxwa != null) {
              restrictions = upgrade_data.restrictionsxwa;
            } else {
              (upgrade_data.restrictions != null ? restrictions = upgrade_data.restrictions : void 0);
            }
          }
          if ((restrictions != null) && ship.restriction_check(restrictions, upgrade_data) && !(((ref1 = ship.pilot) != null ? ref1.upgrades : void 0) != null)) {
            if ((ship.pilot.loadout != null) && (upgrade_data.points + ship.upgrade_points_total > ship.pilot.loadout)) {
              return false;
            }
            slotfree = false;
            ref2 = ship.upgrades;
            for (l = 0, len1 = ref2.length; l < len1; l++) {
              upgrade = ref2[l];
              if (upgrade_data.slot === upgrade.slot && (upgrade.data == null)) {
                slotfree = true;
              }
            }
            if (slotfree === false) {
              return false;
            }
          }
        }
      }
    }
    return true;
  }

  doesSlotExist(slot) {
    var j, len, ref, upgrade;
    ref = this.upgrades;
    for (j = 0, len = ref.length; j < len; j++) {
      upgrade = ref[j];
      if (exportObj.slotsMatching(upgrade.slot, slot)) {
        return true;
      }
    }
    return false;
  }

  isSlotOccupied(slot_name) {
    var j, len, ref, upgrade;
    ref = this.upgrades;
    for (j = 0, len = ref.length; j < len; j++) {
      upgrade = ref[j];
      if (exportObj.slotsMatching(upgrade.slot, slot_name)) {
        if (!upgrade.isOccupied()) {
          return true;
        }
      }
    }
    return false;
  }

  checkKeyword(keyword) {
    var j, l, len, len1, len2, len3, m, o, ref, ref1, ref2, ref3, ref4, ref5, ref6, ref7, ref8, upgrade, word, words;
    if ((ref = this.data.name) != null ? ref.includes(keyword) : void 0) {
      return true;
    }
    if (this.pilot.chassis != null) {
      if (this.pilot.chassis === keyword) {
        return true;
      }
    } else {
      if ((this.data.chassis != null) && this.data.chassis === keyword) {
        return true;
      }
    }
    ref2 = (ref1 = this.data.keyword) != null ? ref1 : [];
    for (j = 0, len = ref2.length; j < len; j++) {
      words = ref2[j];
      if (words === keyword) {
        return true;
      }
    }
    ref4 = (ref3 = this.pilot.keyword) != null ? ref3 : [];
    for (l = 0, len1 = ref4.length; l < len1; l++) {
      words = ref4[l];
      if (words === keyword) {
        return true;
      }
    }
    ref5 = this.upgrades;
    for (m = 0, len2 = ref5.length; m < len2; m++) {
      upgrade = ref5[m];
      if ((upgrade.chassis != null) && upgrade.chassis === keyword) {
        return true;
      }
      ref8 = (ref6 = upgrade != null ? (ref7 = upgrade.data) != null ? ref7.keyword : void 0 : void 0) != null ? ref6 : [];
      for (o = 0, len3 = ref8.length; o < len3; o++) {
        word = ref8[o];
        if (word === keyword) {
          return true;
        }
      }
    }
    return false;
  }

  checkListForUnique(name) {
    var ref, t, thing, things;
    ref = this.builder.uniques_in_use;
    for (t in ref) {
      things = ref[t];
      if (t !== 'Slot') {
        if (indexOf.call((function() {
          var j, len, results1;
          results1 = [];
          for (j = 0, len = things.length; j < len; j++) {
            thing = things[j];
            results1.push(thing.canonical_name.getXWSBaseName());
          }
          return results1;
        })(), name) >= 0) {
          return true;
        }
      }
    }
    return false;
  }

  toXWS() {
    var j, len, ref, ref1, ref2, upgrade, upgrade_obj, xws;
    xws = {
      id: (ref = this.pilot.xws) != null ? ref : this.pilot.canonical_name,
      name: (ref1 = this.pilot.xws) != null ? ref1 : this.pilot.canonical_name, // name is no longer part of xws 2.0.0, and was replaced by id. However, we will add it here for some kind of backward compatibility. May be removed, as soon as everybody is using id. 
      points: this.getPoints(),
      //ship: @data.canonical_name
      ship: this.data.name.canonicalize()
    };
    if (this.data.multisection) {
      xws.multisection = this.data.multisection.slice(0);
    }
    upgrade_obj = {};
    if (!this.pilot.upgrades) {
      ref2 = this.upgrades;
      for (j = 0, len = ref2.length; j < len; j++) {
        upgrade = ref2[j];
        if ((upgrade != null ? upgrade.data : void 0) != null) {
          upgrade.toXWS(upgrade_obj);
        }
      }
    }
    if (Object.keys(upgrade_obj).length > 0) {
      xws.upgrades = upgrade_obj;
    }
    return xws;
  }

  getConditions() {
    var condition, conditions, j, l, len, len1, len2, m, ref, ref1, ref2, ref3, ref4, upgrade;
    if (typeof Set !== "undefined" && Set !== null) {
      conditions = new Set();
      if (((ref = this.pilot) != null ? ref.applies_condition : void 0) != null) {
        if (this.pilot.applies_condition instanceof Array) {
          ref1 = this.pilot.applies_condition;
          for (j = 0, len = ref1.length; j < len; j++) {
            condition = ref1[j];
            conditions.add(exportObj.conditionsByCanonicalName[condition]);
          }
        } else {
          conditions.add(exportObj.conditionsByCanonicalName[this.pilot.applies_condition]);
        }
      }
      ref2 = this.upgrades;
      for (l = 0, len1 = ref2.length; l < len1; l++) {
        upgrade = ref2[l];
        if ((upgrade != null ? (ref3 = upgrade.data) != null ? ref3.applies_condition : void 0 : void 0) != null) {
          if (upgrade.data.applies_condition instanceof Array) {
            ref4 = upgrade.data.applies_condition;
            for (m = 0, len2 = ref4.length; m < len2; m++) {
              condition = ref4[m];
              conditions.add(exportObj.conditionsByCanonicalName[condition]);
            }
          } else {
            conditions.add(exportObj.conditionsByCanonicalName[upgrade.data.applies_condition]);
          }
        }
      }
      return conditions;
    } else {
      console.warn('Set not supported in this JS implementation, not implementing conditions');
      return [];
    }
  }

};

GenericAddon = class GenericAddon {
  constructor(args) {
    // args
    this.ship = args.ship;
    this.container = $(args.container);
    // internal state
    this.data = null;
    this.unadjusted_data = null;
    this.conferredAddons = [];
    this.serialization_code = 'X';
    this.occupied_by = null;
    this.occupying = [];
    this.destroyed = false;
    // Overridden by children
    this.type = null;
    this.dataByName = null;
    this.dataById = null;
    if (args.adjustment_func != null) {
      this.adjustment_func = args.adjustment_func;
    }
    if (args.filter_func != null) {
      this.filter_func = args.filter_func;
    }
    this.placeholderMod_func = args.placeholderMod_func != null ? args.placeholderMod_func : (x) => {
      return x;
    };
  }

  async destroy(cb, ...args) {
    var isLastShip, j, len, ref, ref1, ship;
    if (this.destroyed) {
      return cb(args);
    }
    if (((ref = this.data) != null ? ref.unique : void 0) != null) {
      await new Promise((resolve, reject) => {
        return this.ship.builder.container.trigger('xwing:releaseUnique', [this.data, this.type, resolve]);
      });
    }
    if (this.isStandardized()) {
      isLastShip = true;
      ref1 = this.ship.builder.ships;
      for (j = 0, len = ref1.length; j < len; j++) {
        ship = ref1[j];
        if ((ship.data != null) && (this.ship.data.name === ship.data.name) && (this.ship !== ship)) {
          isLastShip = false;
        }
      }
      if (isLastShip === true) {
        this.ship.removeStandardizedList(this.data);
      }
    }
    this.destroyed = true;
    this.rescindAddons();
    this.deoccupyOtherUpgrades();
    this.selector.select2('destroy');
    this.selectorwrap.remove();
    return cb(args);
  }

  isStandardized() {
    var ref, ref1;
    if (this.ship.builder.isXwa) {
      if (((ref = this.data) != null ? ref.standardizedxwa : void 0) != null) {
        return this.data.standardizedxwa;
      }
    }
    if (((ref1 = this.data) != null ? ref1.standardized : void 0) != null) {
      return true;
    }
    return false;
  }

  setupSelector(args) {
    this.selectorwrap = $(document.createElement('div'));
    this.selectorwrap.addClass('form-group d-flex upgrade-box');
    this.selector = $(document.createElement('INPUT'));
    this.selector.attr('type', 'hidden');
    this.selectorwrap.append(this.selector);
    this.selectorwrap.append($.trim(`<div class="input-group-addon">
    <button class="btn btn-secondary d-block d-md-none upgrade-query-modal"><i class="fas fa-question"></i></button>
</div>`));
    this.upgrade_query_modal = $(this.selectorwrap.find('button.upgrade-query-modal'));
    this.container.append(this.selectorwrap);
    if ($.isMobile()) {
      args.minimumResultsForSearch = -1;
    }
    args.formatResultCssClass = (obj) => {
      var not_in_collection, ref;
      if (this.ship.builder.collection != null) {
        not_in_collection = false;
        if (obj.id === ((ref = this.data) != null ? ref.id : void 0)) {
          // Currently selected card; mark as not in collection if it's neither
          // on the shelf nor on the table
          if (!(this.ship.builder.collection.checkShelf(this.type.toLowerCase(), obj.name) || this.ship.builder.collection.checkTable(this.type.toLowerCase(), obj.name))) {
            not_in_collection = true;
          }
        } else {
          // Not currently selected; check shelf only
          not_in_collection = !this.ship.builder.collection.checkShelf(this.type.toLowerCase(), obj.name);
        }
        if (not_in_collection) {
          return 'select2-result-not-in-collection';
        } else {
          return '';
        }
      } else {
        return '';
      }
    };
    args.formatSelection = (obj, container) => {
      var icon;
      icon = (function() {
        switch (this.type) {
          case 'Upgrade':
            return this.slot.toLowerCase().replace(/[^0-9a-z]/gi, '');
          default:
            return this.type.toLowerCase().replace(/[^0-9a-z]/gi, '');
        }
      }).call(this);
      icon = icon.replace("configuration", "config").replace("force", "forcepower");
      
      // Append directly so we don't have to disable markup escaping
      $(container).append(`<i class="xwing-miniatures-font xwing-miniatures-font-${icon}"></i> ${obj.text}`);
      // If you return a string, Select2 will render it
      return void 0;
    };
    this.selector.select2(args);
    this.upgrade_query_modal.click((e) => {
      if (this.data) {
        console.log(`${this.data.name}`);
        this.ship.builder.showTooltip('Addon', this.data, (this.data != null ? {
          addon_type: this.type
        } : void 0), this.ship.builder.mobile_tooltip_modal, true);
        return this.ship.builder.mobile_tooltip_modal.modal('show');
      }
    });
    this.selector.on('select2-focus', (e) => {
      if ($.isMobile()) {
        $('.select2-container .select2-focusser').remove();
        return $('.select2-search input').prop('focus', false).removeClass('select2-focused');
      }
    });
    this.selector.on('change', (e) => {
      this.setById(this.selector.select2('val'));
      this.ship.builder.current_squad.dirty = true;
      this.ship.builder.container.trigger('xwing-backend:squadDirtinessChanged');
      return this.ship.builder.backend_status.fadeOut('slow');
    });
    this.selector.data('select2').results.on('mousemove-filtered', (e) => {
      var select2_data;
      select2_data = $(e.target).closest('.select2-result').data('select2-data');
      if ((select2_data != null ? select2_data.id : void 0) != null) {
        return this.ship.builder.showTooltip('Addon', this.dataById[select2_data.id], {
          addon_type: this.type
        });
      }
    });
    return this.selector.data('select2').container.on('mouseover', (e) => {
      if (this.data != null) {
        return this.ship.builder.showTooltip('Addon', this.data, {
          addon_type: this.type
        });
      }
    });
  }

  setById(id) {
    return this.setData(this.dataById[parseInt(id)]);
  }

  setByName(name) {
    return this.setData(this.dataByName[$.trim(name)]);
  }

  async setData(new_data) {
    var alreadyClaimed, ref, ref1, ref2, ref3;
    if ((new_data != null ? new_data.id : void 0) !== ((ref = this.data) != null ? ref.id : void 0)) {
      if ((((ref1 = this.data) != null ? ref1.unique : void 0) != null) || (((ref2 = this.data) != null ? ref2.solitary : void 0) != null)) {
        await new Promise((resolve, reject) => {
          return this.ship.builder.container.trigger('xwing:releaseUnique', [this.unadjusted_data, this.type, resolve]);
        });
      }
      if (this.isStandardized() && !this.ship.hasFixedUpgrades) {
        this.ship.removeStandardizedList(this.data);
      }
      await this.rescindAddons();
      this.deoccupyOtherUpgrades();
      if (((new_data != null ? new_data.unique : void 0) != null) || ((new_data != null ? new_data.solitary : void 0) != null)) {
        try {
          await new Promise((resolve, reject) => {
            return this.ship.builder.container.trigger('xwing:claimUnique', [new_data, this.type, resolve]);
          });
        } catch (error1) {
          alreadyClaimed = error1;
          this.ship.builder.container.trigger('xwing:pointsUpdated');
          this.lastSetValid = false;
          return;
        }
      }
      // Need to make a copy of the data, but that means I can't just check equality
      this.data = this.unadjusted_data = new_data;
      if (this.data != null) {
        if (this.data.superseded_by_id) {
          return this.setById(this.data.superseded_by_id);
        }
        if (this.adjustment_func != null) {
          this.data = this.adjustment_func(this.data);
        }
        if (((ref3 = this.ship.pilot) != null ? ref3.upgrades : void 0) == null) {
          this.unequipOtherUpgrades();
          this.occupyOtherUpgrades();
          this.conferAddons();
        }
        if (this.isStandardized() && !this.ship.hasFixedUpgrades) {
          this.ship.addToStandardizedList(this.data);
        }
      } else {
        this.deoccupyOtherUpgrades();
      }
      // this will remove not allowed upgrades (is also done on pointsUpdated). We do it explicitly so we can tell if the setData was successfull
      await (this.lastSetValid = this.ship.validate());
      return this.ship.builder.container.trigger('xwing:pointsUpdated');
    }
  }

  conferAddons() {
    var addon, args, cls, j, l, len, len1, ref, ref1, results1;
    if ((this.data.confersAddons != null) && !this.ship.builder.isQuickbuild && this.data.confersAddons.length > 0) {
      ref = this.data.confersAddons;
      for (j = 0, len = ref.length; j < len; j++) {
        addon = ref[j];
        cls = addon.type;
        args = {
          ship: this.ship,
          container: this.container
        };
        if (addon.slot != null) {
          args.slot = addon.slot;
        }
        if (addon.adjustment_func != null) {
          args.adjustment_func = addon.adjustment_func;
        }
        if (addon.filter_func != null) {
          args.filter_func = addon.filter_func;
        }
        if (addon.auto_equip != null) {
          args.auto_equip = addon.auto_equip;
        }
        if (addon.placeholderMod_func != null) {
          args.placeholderMod_func = addon.placeholderMod_func;
        }
        addon = new cls(args);
        if (addon instanceof exportObj.Upgrade) {
          this.ship.upgrades.push(addon);
        } else {
          throw new Error(`Unexpected addon type for addon ${addon}`);
        }
        this.conferredAddons.push(addon);
      }
    }
    if ((this.data.chassis != null) && !this.ship.builder.isQuickbuild && (exportObj.chassis[this.data.chassis].conferredAddons != null)) {
      ref1 = exportObj.chassis[this.data.chassis].conferredAddons;
      results1 = [];
      for (l = 0, len1 = ref1.length; l < len1; l++) {
        addon = ref1[l];
        cls = addon.type;
        args = {
          ship: this.ship,
          container: this.container
        };
        if (addon.slot != null) {
          args.slot = addon.slot;
        }
        if (addon.adjustment_func != null) {
          args.adjustment_func = addon.adjustment_func;
        }
        if (addon.filter_func != null) {
          args.filter_func = addon.filter_func;
        }
        if (addon.auto_equip != null) {
          args.auto_equip = addon.auto_equip;
        }
        if (addon.placeholderMod_func != null) {
          args.placeholderMod_func = addon.placeholderMod_func;
        }
        addon = new cls(args);
        if (addon instanceof exportObj.Upgrade) {
          this.ship.upgrades.push(addon);
        } else {
          throw new Error(`Unexpected addon type for addon ${addon}`);
        }
        results1.push(this.conferredAddons.push(addon));
      }
      return results1;
    }
  }

  async rescindAddons() {
    var addon, destroyed_addons, j, l, len, len1, ref, ref1;
    destroyed_addons = [];
    ref = this.conferredAddons;
    for (j = 0, len = ref.length; j < len; j++) {
      addon = ref[j];
      destroyed_addons.push(new Promise(((resolve, reject) => {
        return addon.destroy(resolve);
      })));
    }
    await Promise.all(destroyed_addons);
    ref1 = this.conferredAddons;
    for (l = 0, len1 = ref1.length; l < len1; l++) {
      addon = ref1[l];
      if (addon instanceof exportObj.Upgrade) {
        this.ship.upgrades.removeItem(addon);
      } else {
        throw new Error(`Unexpected addon type for addon ${addon}`);
      }
    }
    return this.conferredAddons = [];
  }

  getPoints(data = this.data, ship = this.ship) {
    var points, ref, ref1;
    // Moar special case jankiness
    if (((ref = this.ship) != null ? ref.builder.isXwa : void 0) && ((data != null ? data.pointsxwa : void 0) != null)) {
      points = data.pointsxwa;
    } else {
      points = (ref1 = data != null ? data.points : void 0) != null ? ref1 : 0;
    }
    if (Array.isArray(points)) {
      switch (data.variablepoints) {
        case "Agility":
          return points[ship.data.agility];
        case "Base":
          if ((ship != null ? ship.data.base : void 0) != null) {
            switch (ship.data.base) {
              case "Medium":
                return points[1];
              case "Large":
                return points[2];
              case "Huge":
                return points[3];
            }
          } else {
            return points[0];
          }
          break;
        case "Initiative":
          return points[ship.pilot.skill];
        case "Faction":
          return points[data.faction.indexOf(ship.builder.faction)];
      }
    } else {
      return points;
    }
  }

  updateSelection(points) {
    if (this.data != null) {
      return this.selector.select2('data', {
        id: this.data.id,
        text: `${this.data.display_name ? this.data.display_name : this.data.name} (${points}${this.data.variablepoints ? '*' : ''})`
      });
    } else {
      return this.selector.select2('data', null);
    }
  }

  toString() {
    if (this.data != null) {
      return `${this.data.display_name ? this.data.display_name : this.data.name} (${this.getPoints()})`;
    } else {
      return `No ${this.type}`;
    }
  }

  toHTML(points) {
    var attackHTML, attackIcon, attackStats, attackrangebonus, base1, chargeHTML, count, forceHTML, forcerecurring, match_array, recurringicon, ref, restriction_html, text_str, upgrade_slot_font;
    if (this.data != null) {
      if ((this.data.slot != null) && this.data.slot === "HardpointShip") {
        upgrade_slot_font = "hardpoint";
      } else {
        upgrade_slot_font = ((ref = this.data.slot) != null ? ref : this.type).toLowerCase().replace(/[^0-9a-z]/gi, '');
      }
      match_array = typeof (base1 = this.data).text === "function" ? base1.text(match(/(<span.*<\/span>)<br \/><br \/>(.*)/)) : void 0;
      if (match_array) {
        restriction_html = '<div class="card-restriction-container">' + match_array[1] + '</div>';
        text_str = match_array[2];
      } else {
        restriction_html = '';
        text_str = this.data.text;
      }
      attackHTML = "";
      if (this.data.range != null) {
        attackrangebonus = (this.data.rangebonus != null) ? `<span class="upgrade-attack-rangebonus"><i class="xwing-miniatures-font xwing-miniatures-font-rangebonusindicator"></i></span>` : '';
        attackStats = $.trim(`<span class="upgrade-attack-range">${this.data.range}</span>
${attackrangebonus}`);
        attackIcon = (this.data.attack != null) ? $.trim(`<span class="info-data info-attack">${this.data.attack}</span>
<i class="xwing-miniatures-font xwing-miniatures-font-frontarc"></i>`) : (this.data.attackf != null) ? $.trim(`<span class="info-data info-attack">${this.data.attackf}</span>
<i class="xwing-miniatures-font xwing-miniatures-font-fullfrontarc"></i>`) : (this.data.attackb != null) ? $.trim(`<span class="info-data info-attack">${this.data.attackb}</span>
<i class="xwing-miniatures-font xwing-miniatures-font-backarc"></i>`) : (this.data.attackt != null) ? $.trim(`<span class="info-data info-attack">${this.data.attackt}</span>
<i class="xwing-miniatures-font xwing-miniatures-font-singleturretarc"></i>`) : (this.data.attackdt != null) ? $.trim(`<span class="info-data info-attack">${this.data.attackdt}</span>
<i class="xwing-miniatures-font xwing-miniatures-font-doubleturretarc"></i>`) : (this.data.attackl != null) ? $.trim(`<span class="info-data info-attack">${this.data.attackl}</span>
<i class="xwing-miniatures-font xwing-miniatures-font-leftarc"></i>`) : (this.data.attackr != null) ? $.trim(`<span class="info-data info-attack">${this.data.attackr}</span>
<i class="xwing-miniatures-font xwing-miniatures-font-rightarc"></i>`) : (this.data.attackbull != null) ? $.trim(`<span class="info-data info-attack">${this.data.attackbull}</span>
<i class="xwing-miniatures-font xwing-miniatures-font-bullseyearc"></i>`) : '';
        attackHTML = $.trim(`<div class="upgrade-attack">
    ${attackStats}
    ${attackIcon}
</div>`);
      }
      if (this.data.charge != null) {
        recurringicon = '';
        if (this.data.recurring != null) {
          if (this.data.recurring > 0) {
            count = 0;
            while (count < this.data.recurring) {
              recurringicon += '<sup><i class="fas fa-caret-up"></i></sup>';
              ++count;
            }
          } else {
            count = this.data.recurring;
            while (count < 0) {
              recurringicon += '<sub><i class="fas fa-caret-down"></i></sub>';
              ++count;
            }
          }
        }
        chargeHTML = $.trim(`<div class="upgrade-charge">
    <span class="info-data info-charge">${this.data.charge}</span>
    <i class="xwing-miniatures-font xwing-miniatures-font-charge"></i>${recurringicon}
</div>`);
      } else {
        chargeHTML = $.trim('');
      }
      if ((this.data.force != null)) {
        forcerecurring = 1;
        if (this.data.forcerecurring != null) {
          forcerecurring = this.data.forcerecurring;
        }
        count = 0;
        recurringicon = '';
        while (count < forcerecurring) {
          recurringicon += '<sup><i class="fas fa-caret-up"></i></sup>';
          ++count;
        }
        forceHTML = $.trim(`<div class="upgrade-force">
    <span class="info-data info-force">${this.data.force}</span>
    <i class="xwing-miniatures-font xwing-miniatures-font-forcecharge"></i>${recurringicon}
</div>`);
      } else {
        forceHTML = $.trim('');
      }
      return $.trim(`<div class="upgrade-container">
    <div class="upgrade-stats">
        <div class="upgrade-name"><i class="xwing-miniatures-font xwing-miniatures-font-${upgrade_slot_font}"></i>${this.data.display_name ? this.data.display_name : this.data.name}</div>
        <div class="mask">
            <div class="outer-circle">
                <div class="inner-circle upgrade-points">${points}</div>
            </div>
        </div>
        ${restriction_html}
    </div>
    ${attackHTML}
    ${chargeHTML}
    ${forceHTML}
    <div class="upgrade-text">${text_str}</div>
    <div style="clear: both;"></div>
</div>`);
    } else {
      return '';
    }
  }

  toTableRow(points) {
    if (this.data != null) {
      return $.trim(`<tr class="simple-addon">
    <td class="name">${this.data.display_name ? this.data.display_name : this.data.name}</td>
    <td class="points">${points}</td>
</tr>`);
    } else {
      return '';
    }
  }

  toSimpleCopy(points) {
    if (this.data != null) {
      return `${this.data.name} (${points})    \n`;
    } else {
      return null;
    }
  }

  toRedditText(points) {
    if (this.data != null) {
      return `*&nbsp;${this.data.name} (${points})*    \n`;
    } else {
      return null;
    }
  }

  toTTSText() {
    if (this.data != null) {
      return `${exportObj.toTTS(this.data.name)}`;
    } else {
      return null;
    }
  }

  toSerialized() {
    var ref, ref1;
    return `${this.serialization_code}.${(ref = (ref1 = this.data) != null ? ref1.id : void 0) != null ? ref : -1}`;
  }

  unequipOtherUpgrades() {
    var j, len, ref, ref1, ref2, results1, slot, upgrade;
    ref2 = (ref = (ref1 = this.data) != null ? ref1.unequips_upgrades : void 0) != null ? ref : [];
    results1 = [];
    for (j = 0, len = ref2.length; j < len; j++) {
      slot = ref2[j];
      results1.push((function() {
        var l, len1, ref3, results2;
        ref3 = this.ship.upgrades;
        results2 = [];
        for (l = 0, len1 = ref3.length; l < len1; l++) {
          upgrade = ref3[l];
          if (!exportObj.slotsMatching(upgrade.slot, slot) || upgrade === this || !upgrade.isOccupied()) {
            continue;
          }
          upgrade.setData(null);
          break;
        }
        return results2;
      }).call(this));
    }
    return results1;
  }

  isOccupied() {
    return (this.data != null) || (this.occupied_by != null);
  }

  occupyOtherUpgrades() {
    var checkupgrades, j, len, ref, ref1, ref2, ref3, results1, slot, upgrade;
    checkupgrades = [];
    if (this.ship.builder.isXwa && (((ref = this.data) != null ? ref.also_occupies_upgrades_xwa : void 0) != null)) {
      checkupgrades = (ref1 = this.data) != null ? ref1.also_occupies_upgrades_xwa : void 0;
    } else {
      if (((ref2 = this.data) != null ? ref2.also_occupies_upgrades : void 0) != null) {
        checkupgrades = (ref3 = this.data) != null ? ref3.also_occupies_upgrades : void 0;
      }
    }
    results1 = [];
    for (j = 0, len = checkupgrades.length; j < len; j++) {
      slot = checkupgrades[j];
      results1.push((function() {
        var l, len1, ref4, results2;
        ref4 = this.ship.upgrades;
        results2 = [];
        for (l = 0, len1 = ref4.length; l < len1; l++) {
          upgrade = ref4[l];
          if (!exportObj.slotsMatching(upgrade.slot, slot) || upgrade === this || upgrade.isOccupied()) {
            continue;
          }
          this.occupy(upgrade);
          break;
        }
        return results2;
      }).call(this));
    }
    return results1;
  }

  deoccupyOtherUpgrades() {
    var j, len, ref, results1, upgrade;
    ref = this.occupying;
    results1 = [];
    for (j = 0, len = ref.length; j < len; j++) {
      upgrade = ref[j];
      results1.push(this.deoccupy(upgrade));
    }
    return results1;
  }

  occupy(upgrade) {
    upgrade.occupied_by = this;
    upgrade.selector.select2('enable', false);
    return this.occupying.push(upgrade);
  }

  deoccupy(upgrade) {
    upgrade.occupied_by = null;
    return upgrade.selector.select2('enable', true);
  }

  occupiesAnUpgradeSlot(upgradeslot) {
    var j, len, ref, upgrade;
    ref = this.ship.upgrades;
    for (j = 0, len = ref.length; j < len; j++) {
      upgrade = ref[j];
      if (!exportObj.slotsMatching(upgrade.slot, upgradeslot) || upgrade === this || (upgrade.data != null)) {
        continue;
      }
      if ((upgrade.occupied_by != null) && upgrade.occupied_by === this) {
        return true;
      }
    }
    return false;
  }

  toXWS(upgrade_dict) {
    var name1, ref, ref1;
    return (upgrade_dict[name1 = (ref1 = exportObj.toXWSUpgrade[this.data.slot]) != null ? ref1 : this.data.slot.canonicalize()] != null ? upgrade_dict[name1] : upgrade_dict[name1] = []).push((ref = this.data.xws) != null ? ref : this.data.canonical_name);
  }

};

exportObj.Upgrade = class Upgrade extends GenericAddon {
  constructor(args) {
    // args
    super(args);
    this.slot = args.slot;
    this.type = 'Upgrade';
    this.dataById = exportObj.upgradesById;
    this.dataByName = exportObj.upgrades;
    this.serialization_code = 'U';
    this.setupSelector();
  }

  setupSelector() {
    return super.setupSelector({
      width: '100%',
      placeholder: this.placeholderMod_func(exportObj.translate('ui', 'upgradePlaceholder', this.slot)),
      allowClear: true,
      query: (query) => {
        var data;
        data = {
          results: []
        };
        data.results = this.ship.builder.getAvailableUpgradesIncluding(this.slot, this.data, this.ship, this, query.term, this.filter_func);
        return query.callback(data);
      }
    });
  }

};

exportObj.RestrictedUpgrade = class RestrictedUpgrade extends exportObj.Upgrade {
  constructor(args) {
    super(args);
    this.serialization_code = 'u';
    if (args.auto_equip != null) {
      this.setById(args.auto_equip);
    }
  }

};

exportObj.QuickbuildUpgrade = class QuickbuildUpgrade extends GenericAddon {
  constructor(args) {
    super(args);
    this.slot = args.slot;
    this.type = 'Upgrade';
    this.dataById = exportObj.upgradesById;
    this.dataByName = exportObj.upgrades;
    this.serialization_code = 'U';
    this.upgrade = args.upgrade;
    this.setupSelector();
  }

  setupSelector() {
    return super.setupSelector({
      width: '100%',
      allowClear: false,
      query: (query) => {
        var data;
        data = {
          results: [
            {
              id: this.upgrade.id,
              text: this.upgrade.display_name ? this.upgrade.display_name : this.upgrade.name,
              points: 0,
              name: this.upgrade.name,
              display_name: this.upgrade.display_name
            }
          ]
        };
        return query.callback(data);
      }
    });
  }

  getPoints(args) {
    return 0;
  }

  updateSelection(args) {
    if (this.data != null) {
      return this.selector.select2('data', {
        id: this.data.id,
        text: `${this.data.display_name ? this.data.display_name : this.data.name}`
      });
    } else {
      return this.selector.select2('data', null);
    }
  }

};

SERIALIZATION_CODE_TO_CLASS = {
  'U': exportObj.Upgrade,
  'u': exportObj.RestrictedUpgrade
};

exportObj = typeof exports !== "undefined" && exports !== null ? exports : this;

exportObj.fromXWSFaction = {
  'rebelalliance': 'Rebel Alliance',
  'rebels': 'Rebel Alliance',
  'rebel': 'Rebel Alliance',
  'galacticempire': 'Galactic Empire',
  'imperial': 'Galactic Empire',
  'scumandvillainy': 'Scum and Villainy',
  'firstorder': 'First Order',
  'resistance': 'Resistance',
  'galacticrepublic': 'Galactic Republic',
  'separatistalliance': 'Separatist Alliance'
};

exportObj.toXWSFaction = {
  'Rebel Alliance': 'rebelalliance',
  'Galactic Empire': 'galacticempire',
  'Scum and Villainy': 'scumandvillainy',
  'First Order': 'firstorder',
  'Resistance': 'resistance',
  'Galactic Republic': 'galacticrepublic',
  'Separatist Alliance': 'separatistalliance'
};

exportObj.toXWSUpgrade = {
  'Modification': 'modification',
  'Force': 'force-power',
  'Tactical Relay': 'tactical-relay'
};

exportObj.fromXWSUpgrade = {
  'amd': 'Astromech',
  'astromechdroid': 'Astromech',
  'ept': 'Talent',
  'elitepilottalent': 'Talent',
  'system': 'Sensor',
  'mod': 'Modification',
  'force-power': 'Force',
  'tactical-relay': 'Tactical Relay'
};

SPEC_URL = 'https://github.com/elistevens/xws-spec';

SQUAD_TO_XWS_URL = 'https://squad2xws.herokuapp.com/translate/';

exportObj.loadXWSButton = function(xws_import_modal) {
  var import_status;
  import_status = $(xws_import_modal.find('.xws-import-status'));
  import_status.text(exportObj.translate('ui', 'Loading...'));
  return ((import_status) => {
    var e, input, jsonurl, loadxws, uuid, xws;
    loadxws = (xws) => {
      return $(window).trigger('xwing:activateBuilder', [
        exportObj.fromXWSFaction[xws.faction],
        (builder) => {
          if (builder.current_squad.dirty && (builder.backend != null)) {
            xws_import_modal.modal('hide');
            return builder.backend.warnUnsaved(builder,
        () => {
              return builder.loadFromXWS(xws,
        (res) => {
                if (!res.success) {
                  xws_import_modal.modal('show');
                  return import_status.text(res.error);
                }
              });
            });
          } else {
            return builder.loadFromXWS(xws,
        (res) => {
              if (res.success) {
                return xws_import_modal.modal('hide');
              } else {
                return import_status.text(res.error);
              }
            });
          }
        }
      ]);
    };
    input = xws_import_modal.find('.xws-content').val();
    try {
      // try if we got a JSON input
      xws = JSON.parse(input);
      return loadxws(xws);
    } catch (error1) {
      e = error1;
      // we did not get JSON. Maybe we got an official builder link/uid
      // strip everything before the last /
      uuid = input.split('/').pop();
      jsonurl = SQUAD_TO_XWS_URL + uuid;
      // let squad2xws create an xws for us and read this
      return ($.getJSON(jsonurl, loadxws)).catch((e) => {
        return import_status.text('Invalid Input');
      });
    }
  })(import_status);
};

//# sourceMappingURL=xwing.js.map
